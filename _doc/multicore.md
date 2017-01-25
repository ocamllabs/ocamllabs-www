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

## More Information

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

