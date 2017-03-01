---
title: Formalizing the OCaml multicore memory model
layout: post
author: sdolan
category: RFC
tags: multicore
---

A (draft!) memory model is [now available](https://github.com/ocamllabs/ocaml-multicore/wiki/Memory-model) for multicore OCaml, which answers the question of what you get when you read a shared mutable memory reference.

In single-threaded code, the answer is "whatever you most recently wrote", but in multi-threaded code with complex synchronisation exactly what "most recently" means becomes murky.  Read the [multicore wiki entry](https://github.com/ocamllabs/ocaml-multicore/wiki/Memory-model) for more details.
