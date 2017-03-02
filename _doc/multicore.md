---
authors: [kc, sdolan]
title: "Multicore OCaml"
layout: page
---

The goal of Multicore OCaml is to add shared memory parallelism to
OCaml. Our implementation uses [algebraic
effects](http://www.eff-lang.org/) to compose concurrency and supports
parallelism through domains and incremental GC. Rather than adding a
specific multicore scheduler into the runtime system, we're providing
the minimum required toolset in the form of pluggable schedulers.

----

{% include news.html name="multicore" %}
