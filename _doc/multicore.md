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

{% include news.html name="multicore" %}

## Repositories

-   [GitHub: Multicore
    OCaml](https://github.com/ocamllabs/ocaml-multicore)
-   [`ocaml-effects`](https://github.com/ocamllabs/ocaml-effects)
-   [Examples of effects and
    handlers](https://github.com/kayceesrk/ocaml-eff-example)
-   [`reagents`](https://github.com/ocamllabs/reagents)

## Articles

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

## Talks/Presentations

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

