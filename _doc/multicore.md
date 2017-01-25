---
authors: [kc, sdolan]
title: "Multicore OCaml"
layout: page
---

## Overview

The goal of Multicore OCaml is to add shared memory parallelism to
OCaml. Our implementation uses [algebraic
effects](http://www.eff-lang.org/) to compose concurrency and supports
parallelism through domains and incremental GC. Rather than adding a
specific multicore scheduler into the runtime system, we're providing
the minimum required toolset in the form of pluggable schedulers.

## Making progress

**Memory model** Using shared memory allows sharing of complex data
structures and selective parallelisation of hot spots with having to
resort to an entire data structure redesign. We are working on a
comprehensive and safe threading memory model for data-race-free
programs in multicore OCaml.

**Native code support** Native code support for
[multicore](Multicore "wikilink") is
[here](https://github.com/ocamllabs/ocaml-multicore/commit/fc366191ff17fffa24aac34fad64c398d462af6d)!
There is a PR under review to push the multicore branch up to 4.02.2 to
allow for installation of your favourite packages from
[OPAM](OPAM "wikilink"). The goal is to benchmark this new 4.02.2
multicore version with the standard version.

**[Reagents](https://github.com/ocamllabs/reagents)** Composable,
lock-free concurrency library for expressing fine-grained parallel
programs on Multicore OCaml

### Why Multicore?

OCaml has good monadic concurrency libraries (`lwt` and `async`) but the
long term goal is to move away from the monadic model towards modular
libraries that support true parallelism - concurrent threads of
execution multiplexed over available cores. Currently, threading is
supported in OCaml via the global interpreter lock (GIL), but this
prohibits multiple threads running OCaml code at any one time. Our goal
is to design and implement an OCaml runtime capable of shared-memory
parallelism. `TODO ev:youtube| FzmQTC\_X5R4 |400|right|Multicore OCaml
overview (OCaml Workshop 2014)|frame`

### Challenges

Adding shared-memory parallelism to an existing language presents an
interesting set of challenges. As well as the difficulties of memory
management in a parallel setting, we must maintain as much backwards
compatibility as practicable. This includes not just compatibility of
the language semantics, but also of the performance profile, memory
usage and C bindings.

The biggest challenge is implementing the garbage collector. GC in OCaml
is interesting because of pervasive immutability. Many objects are
immutable, which simplifies some aspects of a parallel GC but requires
the GC to sustain a very high allocation rate. Operations on immutable
objects are very fast in OCaml: allocation is by bumping a pointer,
initialising writes (the only ones) are done with no barriers, and reads
require no barriers. Our design is focussed on keeping these operations
as fast as they are at the moment, with some compromises for mutable
objects.

### Our approach

A previous design by [Doligez et
al.](http://delivery.acm.org/10.1145/160000/158611/p113-doligez.pdf?ip=131.111.5.142&id=158611&acc=ACTIVE%20SERVICE&key=BF07A2EE685417C5%2E6CDC43D2A5950A53%2E4D4702B0C3E38B35%2E4D4702B0C3E38B35&CFID=612922414&CFTOKEN=76163046&__acm__=1462798064_7716c0a75713b5c2a4fb9ee528b4b1b6)
for Caml Light was based on many thread-private heaps and a single
shared heap. It maintains the invariant that there are no pointers from
the shared to the private heaps. Storing a pointer to a private object
into the shared heap causes the private object and all objects reachable
from it to be promoted to the shared heap en masse. This approach
promotes many objects that were never really shared: just because an
object is pointed to by a shared object does not mean another thread is
actually going to attempt to access it.

Our design is similar but lazier, along the lines of multicore Haskell,
where objects are promoted to the shared heap whenever another thread
actually tries to access them. This has a slower sharing operation,
since it requires synchronisation of two different threads, but it is
performed less often. Collection of the shared heap is based on a
mostly-concurrent mark-and-sweep collector. Marking occurs by changing
the object header, and requires no synchronisation between threads.
After a stop-the-world phase, any unmarked objects are viewed as garbage
and available to be swept.

**Parallelism** is managed via domains: Each domain runs as a separate
system thread in the address space and has a small local heap and a
large shared heap which is shared between all domains. The local heaps
are collected with the existing minor collector (modified to use
thread-local not global state), and long-lived objects are promoted to
the shared heap. Since local heaps are only accessed by a single domain,
no synchronisation between threads is needed at this point of
collection.

**Concurrency** will be managed through fibers: work sharing/stealing
schedulers will distribute the fibers amongst the available domains,
with locking and signalling primitives to achieve mutual exclusion and
inter-domain communication. We will use [ algebraic
effects](Algebraic_Effects "wikilink") and handlers to compose
concurrency in the form of pluggable schedulers.
`TODO \#ev:youtube|jZB8CZRRuEo|400|right|Concurrency with Algebraic Effects
(OCaml Workshop 2015)|frame`

## GC invariants

Garbage collectors work by maintaining quite subtle invariants about how
objects are traced and marked. These can be quite difficult to
understand by reading the implementation, so this page explains the
multicore OCaml collector's invariants and where they come from.

**GC Basics**

The **roots** are the values that can be directly accessed by the
program: global variables and values on the currently-executing stack.
Each domain sees a slightly different set of roots: all domains see the
global roots, yet each domain only sees its own stack roots.

A value is **live** if it is one of the roots, or pointed to by some
other live value. Only live values can ever be used again.

The job of the GC is to make the memory occupied by dead (non-live)
values free for re-use. It's OK if the GC fails to immediately free
memory for a dead value (as long as it is eventually freed), but it must
never free memory for a live value.

The GC divides the heap into the **major** (or **shared**) heap, and the
**minor** heaps. There is one minor heap per domain. First, here's how
the minor heap works (it's simpler than the major).

**Generational GC**

Most objects are not used for very long. So, we allocate objects at
first in a region called the minor heap, using a stupid-but-fast
allocator (pointer subtraction). When the minor heap fills, we copy
every live object in the minor heap to the major heap.

Since most values in the minor heap are not live, this saves a lot of
work by making the effective allocation rate in the major heap much
lower. The minor heap acts as a filter, ensuring we only use the
machinery of the major heap for the small proportion of values which
survive for at least a short while.

Determining exactly which values in the minor heap are live would take
far too long. Instead, we over-approximate: we consider as live any
root, anything pointed to by a live minor value, and anything pointed to
by *any* major value (live or not).

To determine which minor values are pointed to by major values, we use
the **remembered set**, which is a growable array of pointers
(`caml_remembered_set`). Pointers can only be made from the major heap
to the minor heap by mutating some object already in the major heap to
point to something in the minor heap. So, we detect this during
`caml_modify_field` and record the pointer in `caml_remembered_set` (see
`shared_heap_write_barrier` in
[`memory.c`](https://github.com/ocamllabs/ocaml-multicore/blob/master/byterun/memory.c)).

The collector used to clear out the minor heap is almost identical to
that used in stock OCaml.

**GC cycles**

Collecting the major heap is a more complicated matter. The major heap
is too big to collect all at once without introducing a long pause, and
the major heap is operated upon by several domains concurrently (unlike
the minor heaps, which are private to a particular domain).

The major GC operates in **cycles**. During a cycle, the GC figures out
which memory can be safely reused, and allocations are performed using
memory known to be reusable from the *previous* cycle. Once the cycle
completes, a new batch of memory is available for allocations.

All values on the major heap are in one of three states: `MARKED`,
`UNMARKED` or `GARBAGE`, labelled by a two-bit field in the value's
header word (there is a fourth state `NOT_MARKABLE` for things on the
heap that the GC should ignore entirely, but it's not relevant here). A
GC cycle completes when the following three conditions hold:

1\. All roots of all domains are `MARKED`.

2\. No `MARKED` value points to an `UNMARKED` value.

3\. There are no `GARBAGE` values.

These conditions imply that all `UNMARKED` objects are dead. When this
happens, all domains synchronise and the heap is **cycled** (see
`caml_cycle_heap_stw` in
[`shared_heap.c`](https://github.com/ocamllabs/ocaml-multicore/blob/master/byterun/shared_heap.c)),
which means:

- All `MARKED` objects become `UNMARKED`

- All `UNMARKED` objects become `GARBAGE`

Rather than iterating over the heap, this is done by relabelling: the
bit-pattern previously used for `MARKED` is now used for `UNMARKED`,
that used for `UNMARKED` is now used for `GARBAGE`, and that used for
`GARBAGE` is now used for `MARKED`. (This technique is from the
[VCGC](http://doc.cat-v.org/inferno/concurrent_gc/concurrent_gc.pdf)
collector).

Enforcing condition \#3 (that there are no `GARBAGE` objects) is the job
of the sweeper, which finds `GARBAGE` objects and makes them available
for allocation by adding them to freelists. The sweeper is described
below. Here, we're concerned with enforcing conditions \#1 and \#2.

A very simple GC could enforce conditions \#1 and \#2 directly, by
stopping all domains and marking objects until the conditions become
true. Such a collector causes truly obscene pauses, so we complicate
matters in the name of performance by relaxing conditions \#1 and \#2.

Relaxing condition \#1 is easy: we can do a final pass of the roots just
before completing a GC cycle to restore it. Condition \#2 is more
complicated.

**Incremental GC**

Marking all values at once takes far too long, so we break up the work
into smaller units. Each domain maintains a **mark stack** of values for
which marking is in-progress. Values on the mark stack have been marked,
but may still point to unmarked values. So, we weaken condition \#2
above to the following invariant:

2b. All `MARKED` values which point to `UNMARKED` values are on the mark
stack of at least one domain.

To maintain this invariant, when a value on the major heap is mutated,
the new pointee is marked and placed on the mark stack of the domain
that did the mutation. This is called **darkening** the pointee, and is
done by `caml_darken` in
[`major_gc.c`](https://github.com/ocamllabs/ocaml-multicore/blob/master/byterun/major_gc.c).
Maintaining invariant \#2b in this way is known as the Dijkstra barrier.

This specifies "at least one" instead of "exactly one" domain, so it's
possible for an object to be marked twice. This risks a small amount of
duplicate work, but won't cause problems since marking is an idempotent
operation (it amounts to changing some bits in the header from
`UNMARKED` to `MARKED`). By allowing this duplicate work, we avoid
needing mutual exclusion between domains marking the same object, and so
can use unsynchronised operations to do the actual marking. See
`caml_mark_object` in
[`shared_heap.c`](https://github.com/ocamllabs/ocaml-multicore/blob/master/byterun/shared_heap.c).

When it is time to complete a GC cycle, each domain first ensures that
all of its roots are `MARKED` (ensuring condition \#1). Then, each
domain marks objects on its mark stack until its mark stack is empty.
Once all domains have empty mark stacks, the original condition \#2
holds and the GC cycle completes.

Generally, only a small amount of marking is done at the end of a GC
cycle, since most objects will have been marked during the cycle. The
above process is more to verify that marking has completed, rather than
to do a significant amount of marking.

Right now, domains do not load-balance marking. They should.

**Multiple stacks**

As well as heavyweight domains corresponding to system threads,
multicore OCaml supports lightweight fibers. Fibers have their own
stacks, and are subject to garbage collection.

Unlike most other data in OCaml, the stack is continually modified.
Every function call pushes and pops values (local variables) to the
stack. The write barrier described above, which checks for `MARKED` to
`UNMARKED` pointers and major to minor pointers is far too expensive to
run every time a local variable is initialised.

So, we temporarily suspend invariant \#2b for stacks. Stacks may point
to `UNMARKED` values, even though the stack itself is `MARKED`.

For the currently-running stack, this poses no problem. The values
pointed to by the currently-running stack are roots, and so are marked
at the end of a GC cycle, restoring invariant \#2b.

However, stacks that are not currently running may violate \#2b. We call
any stack which may violate this invariant **dirty**. Each domain keeps
track of its set of dirty stacks. So, invariant \#2b is relaxed to the
following:

2c. All `MARKED` values which point to `UNMARKED` values are either:

- on the mark stack of at least one domain, or

- dirty stacks

Whenever a domain context-switches from one stack to another, if the old
stack is on the major heap then it is dirtied. This maintains invariant
\#2c without needing to instrument accesses to local variables.

Before a GC cycle completes, each domain **cleans** its dirty stacks, by
darkening every value pointed to by one of its dirty stacks. When every
domain has no dirty stacks, invariant \#2b holds and GC can proceed as
before.

Strictly speaking, it is only necessary for a domain to clean its dirty
stacks right before the GC cycle completes. Domains actually do this at
every minor GC, for several reasons: to prevent the set of dirty stacks
growing large, because recently-dirtied stacks are likely in cache and
cheap to scan, and to minimise time spent at the completion of a GC
cycle.

## Major heap allocation and sweeping

Allocation and sweeping are very much intertwined in the design of
multicore OCaml, so are best described together.

**Design and goals**

Since all values allocated in OCaml are immediately initialised, a
performance goal for the allocator is to make the cost of allocation
roughly proportional to the cost of initialisation. In other words, very
small objects (lists, options, etc.) must be allocated quickly, while it
is acceptable for larger allocations to be slower.

Allocation is very, very frequent in OCaml, and would easily become a
bottleneck if it involved heavy contention. So, it is important that
allocations by one domain synchronise with other domains as little as
possible.

Stock OCaml does not do incremental compaction, and neither does the
multicore GC. Stock OCaml supports periodic stop-the-world compaction,
which could be (but currently isn't) implemented for multicore. So, it
is important that the allocator avoid fragmentation as much as possible.

**Heap layout**

The allocator is based roughly on the [Streamflow
allocator](http://people.cs.vt.edu/~scschnei/streamflow/). Allocations
are divided into **large** and **small** allocations. Any allocation of
up to 128 words is considered small (that's 1KiB on 64-bit systems, and
512B on 32-bit ones).

Small allocations are divided into
[sizeclasses](https://github.com/ocamllabs/ocaml-multicore/blob/master/byterun/sizeclasses.h)
in such a way that any small allocation fits into some sizeclass with at
most 10% wasted space. The optimal sizeclasses are determined by
[`gen_sizeclasses.ml`](https://github.com/ocamllabs/ocaml-multicore/blob/master/byterun/gen_sizeclasses.ml).

For small allocations, memory is allocated in fixed-size **pools** of
4096 words (32/16 KiB, according to wordsize). Each pool is carved up
into equal-sized slots, and allocates values of only one sizeclass.

Pools which contain at least one value are owned by a particular domain,
and only the owning domain may allocate from a given pool. When a pool
becomes empty, it is returned to a central, shared list of free pools
(although each domain maintains a small cache of free pools to cut down
on synchronisation).

**Allocation and sweeping**

Within a pool, the free slots are kept in a singly-linked list. To
allocate a small object, the allocator first checks if it has a
partially-full pool of the correct sizeclass. If so, the next free slot
from this pool is returned, and otherwise a free pool is acquired and
carved up into slots.

Using the next free slot in a partially-filled pool is very cheap, while
acquiring a free pool is more expensive. There are roughly 4096/n slots
in a pool of sizeclass n, and so a free pool must be acquired once every
4096/n allocations of a given sizeclass. So, the probability of hitting
the slower path of allocation is linear in the size of the allocation,
making the expected cost of allocation proportional to allocation size.

A pool is **swept** by iterating over each of its slots, and adding any
slots containing [`GARBAGE`
values](https://github.com/ocamllabs/ocaml-multicore/wiki/Garbage-collector-invariants#gc-cycles)
to the list of free slots. Pools may be swept in any order, but only by
their owning domain.

For each sizeclass, the allocator maintains four linked lists of pools:

- `avail_pools`: Partially filled, swept pools

- `full_pools`: Fully filled, swept pools

- `unswept_avail_pools`: Partially filled but not swept pools

- `unswept_full_pools`: Fully filled but not swept pools

To allocate an object of a given sizeclass, the allocator must find a
non-full pool of this sizeclass. First, it looks at `avail_pools`. If
this is empty, it sweeps pools in `unswept_avail_pools` and
`unswept_full_pools`, adding them to `avail_pools` and `full_pools` as
appropriate. If this fails to produce a non-full pool, a new pool is
acquired from the central store (or the OS) and carved up into
appropriate-sized slots. Only this final case of acquiring a new pool
requires any mutexes or other synchronisation.

So, instead of proceeding strictly in address order like many collectors
(and stock OCaml), the multicore OCaml GC sweeps pools on-demand. When
an allocation of 5 words is required, the allocator sweeps pools of
5-word objects in order to find a slot that can be reused.

As well as being driven by allocations, the sweeper can be invoked
explicitly as `caml_sweep`. This is done to ensure that all `GARBAGE`
values are swept before the completion of the GC cycle.

**Large values**

Large allocations (of over 128 words) are allocated using system
`malloc`, with a small header. The header is used to place large
allocations in a per-domain linked list, to allow sweeping and freeing.
This is much more expensive than the pool allocator, but as described
above performance is less critical for large allocations.

## Related Pages

### Repositories

-   [GitHub: Multicore
    OCaml](https://github.com/ocamllabs/ocaml-multicore)
-   [`ocaml-effects`](https://github.com/ocamllabs/ocaml-effects)
-   [Examples of effects and
    handlers](https://github.com/kayceesrk/ocaml-eff-example)
-   [`reagents`](https://github.com/ocamllabs/reagents)

### Articles

-   [Initial
    Proposal](https://github.com/ocamllabs/compiler-hacking/wiki/Multicore-runtime) -
    March 2014
-   [Paper: Multicore
    OCaml](https://ocaml.org/meetings/ocaml/2014/ocaml2014_1.pdf) -
    September 2014
-   [Blog: Effective concurrency with algebraic
    effects](http://kcsrk.info/ocaml/multicore/2015/05/20/effects-multicore/) -
    May 2015
-   [Blog: Pearls of algebraic effects and
    handlers](http://kcsrk.info/ocaml/multicore/effects/2015/05/27/more-effects/) -
    May 2015
-   [Blog: Lock-free programming for the
    masses](http://kcsrk.info/ocaml/multicore/2016/06/11/lock-free/) -
    June 2016

### Talks/Presentations

-   [Arrows and
    Reagents](https://speakerdeck.com/kayceesrk/arrows-and-reagents) -
    AFP Course - March 2016
-   [Media:Armael - compiling effects to JS.pdf REMS lunch
    presentation - February
    2016](Media:Armael_-_compiling_effects_to_JS.pdf_REMS_lunch_presentation_-_February_2016 "wikilink")
-   [Concurrent and Multicore OCaml: A Deep
    Dive](https://speakerdeck.com/kayceesrk/concurrent-and-multicore-ocaml-a-deep-dive).
    Presented at Facebook - January 2016
-   [Multicore
    Update](https://www.dropbox.com/s/6kwtxhn366jhjkz/Multicore%20OCaml%20updates.pdf?dl=0) -
    OCaml Dev Meeting - Nov 2015
-   [Effective Concurrency with Algebraic
    Effects](http://kcsrk.info/slides/OCaml15.pdf) - OCaml Workshop -
    September 2015
-   [Multicore
    OCaml](https://www.youtube.com/watch?v=FzmQTC_X5R4&list=UUP9g4dLR7xt6KzCYntNqYcw) -
    OCaml Workshop - September 2014

