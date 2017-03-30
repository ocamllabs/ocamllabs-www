---
title: Lock-free Programming for the Masses
layout: post
author: kc
category: Projects
tags: multicore reagents
---

Progress with multicore is moving forward
nicely, and along with submitting
[PRs](https://github.com/ocamllabs/ocaml-multicore/commit/fc366191ff17fffa24aac34fad64c398d462af6d)
for native code support
KC has introduced [`reagents`](https://github.com/ocamllabs/reagents): a composable,
lock-free concurrency library for expressing fine-grained parallel
programs on multicore OCaml. See the full blog post
[here](http://kcsrk.info/ocaml/multicore/2016/06/11/lock-free/).

This implementation provides a collection of composable, concurrent data
and synchronisation structures such as stacks, queues, countdown
latches, reader-writer locks, condition variables, exchangers and atomic
counters. The implementation requires further optimisation to remove
allocations in the fast path, and fine-tuning the reagents core, but
this provides a great opportunity to build a standard library for
fine-grained parallelism for multicore OCaml, incorporating the latest
developments in lock-free data structures.
