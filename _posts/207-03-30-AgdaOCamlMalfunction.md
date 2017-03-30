---
title: "An OCaml backend for Agda with Malfunctional Programming"
layout: post
author: gemmag
category: News
tags: ocaml compiler verification theorem proof agda malfunction flambda opensource
---

The [experimental backend for Agda](https://github.com/agda/agda-ocaml) targets the OCaml compiler via [Malfunction](https://github.com/stedolan/malfunction) - a library created by OCaml Labs' own [Stephen Dolan](http://mu.netsoc.ie). Malfunction is a compilation target that allows functional programming languages to take advantage of the OCaml flambda optimisations, efficient runtime and garbage collector.

[Agda](https://github.com/agda/agda) is an open-source, dependently typed programming language and proof assistant. With a basis in intuitionistic type theory, it has many similarities with OCaml, and provides the added functionality of constructive logic: a [proposition is proved by writing a program of the corresponding type](http://www.cse.chalmers.se/~ulfn/papers/tphols09/tutorial.pdf).

Related content:

* [Irrelevant Classical Logic in Agda](https://msp-strath.github.io/spls-16/)
* [Malfunctional Programming](http://www.cl.cam.ac.uk/~sd601/papers/malfunction.pdf)

----
