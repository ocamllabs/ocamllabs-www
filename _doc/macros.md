---
authors: [oliviernicole, gemmag, yallop, lpw25, kc]
title: "Macros"
layout: page
---

The OCaml macro system is a language extension for compile-time metaprogramming - essentially a "compile-time MetaOCaml" with additional functionality. The original design was detailed in a [paper](http://www.lpw25.net/ocaml2015-abs1.pdf) by Leo White and Jeremy Yallop in an effort to avoid choosing between code abstraction and performance. Macros fully support the module system in OCaml and make it possible to build low-level code from high-level descriptions, therefore retaining the benefits of abstraction whilst eliminating all interpretative overhead.

Olivier Nicole recently completed his internship at OCaml Labs where he worked on implementing a new OCaml macro system based on the original design described above. Olivier's implementation focussed on changes to the module system, path closures and changes in quote representation. Read the [interim report](https://oliviernicole.github.io/about_macros.html) detailing macros principles and his [full internship report](https://www.slideshare.net/OCamlLabs/development-of-the-ocaml-experimental-macro-system-and-research-on-possible-applications) which poses items for further development.

----

{% include news.html name="macros" %}
