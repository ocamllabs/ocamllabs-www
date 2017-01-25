---
title: AFL merged into OCaml trunk
layout: page
author: gemmag
category: Projects
---

[AFL](http://lcamtuf.coredump.cx/afl/) has been
[merged](https://github.com/ocaml/ocaml/pull/504) into OCaml trunk! Take
care of all of your fuzzing needs and improve the functional coverage of
your code by using
[`ocaml-afl-persistent`](https://github.com/stedolan/ocaml-afl-persistent).

The OCaml AFL project started back at the first
[MirageOS](https://mirage.io/) hackathon in Marrakech [earlier this
year](https://mirage.io/blog/2016-spring-hackathon) by Mindy Preston,
and the [patch](https://github.com/ocaml/ocaml/pull/504) provided by
Stephen Dolan adds support to `ocamlopt` for generating afl compatible
instrumentation and minimal runtime support to communicate with the
fuzzer.

We need more people to fuzz OCaml programs and highlight/fix the
subsequent bugs. It's a great project to get started with, and Mindy
Preston explains how to fuzz a program
[here](http://canopy.mirage.io/Projects/Fuzzing)
