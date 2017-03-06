---
authors: [kc, stedolan]
title: "Multicore OCaml"
layout: page
---

The goal of [Multicore OCaml](https://github.com/ocamllabs/ocaml-multicore) is to add shared memory parallelism to
OCaml. Our implementation uses [algebraic effects](http://www.eff-lang.org/) to compose concurrency and supports parallelism through domains and incremental GC. Rather than adding a specific multicore scheduler into the runtime system, we're providing the minimum required toolset in the form of pluggable schedulers.

**Memory Model**   

Using shared memory allows sharing of complex data structures and selective parallelisation of hot spots with having to resort to an entire data structure redesign. We are working on a comprehensive and safe threading memory model for data-race-free programs in multicore OCaml.

Read the [draft memory model](https://github.com/ocamllabs/ocaml-multicore/wiki/Memory-model) for further details.

**Native code support**

Native code support for is [here](https://github.com/ocamllabs/ocaml-multicore/commit/fc366191ff17fffa24aac34fad64c398d462af6d)! There is a PR under review to push the multicore branch up to 4.02.2 to allow for installation of your favourite packages from opam. The goal is to benchmark this new 4.02.2 multicore version with the standard version.

**[Reagents](https://github.com/ocamllabs/reagents)**

Composable, lock-free concurrency library for expressing fine-grained parallel programs on Multicore OCaml.

## Why Multicore?

OCaml has good monadic concurrency libraries (`lwt` and `async`) but the long term goal is to move away from the monadic model towards modular libraries that support true parallelism - concurrent threads of execution multiplexed over available cores. Currently, threading is supported in OCaml via the global interpreter lock (GIL), but this prohibits multiple threads running OCaml code at any one time. Our goal is to design and implement an OCaml runtime capable of shared-memory parallelism.

## Challenges

Adding shared-memory parallelism to an existing language presents an interesting set of challenges. As well as the difficulties of memory management in a parallel setting, we must maintain as much backwards compatibility as practicable. This includes not just compatibility of the language semantics, but also of the performance profile, memory usage and C bindings.

The biggest challenge is implementing the garbage collector. GC in OCaml is interesting because of pervasive immutability. Many objects are immutable, which simplifies some aspects of a parallel GC but requires the GC to sustain a very high allocation rate. Operations on immutable objects are very fast in OCaml: allocation is by bumping a pointer, initialising writes (the only ones) are done with no barriers, and reads require no barriers. Our design is focussed on keeping these operations as fast as they are at the moment, with some compromises for mutable objects.

Read more about Multicore OCaml on the [repository wiki](https://github.com/ocamllabs/ocaml-multicore/wiki).

----

{% include news.html name="multicore" %}
