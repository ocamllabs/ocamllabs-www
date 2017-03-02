---
authors: [gemmag, avsm, kc]
title: "Documentation"
layout: page
---

We've been working on a collection of tools to automatically generate useful and usable OCaml documentation for ~3 years, with each iteration along the way getting us closer and closer. Our current system now provides automatically generated documentation for a fully interlinked set of modules, all organised in a convenient and user-friendly way.

The system is currently in beta, and you can view the [output for the MirageOS central documentation repository](http://docs.mirage.io/). Please report [issues upstream](https://github.com/ocaml-doc/odoc/issues), and provide other feedback as necessary.

The system is built on top of codoc (see below) and seeks to:

- cover all of OCaml's language features
- provide accurate name resolution and linking
- support cross-linking between packages
- reduce external dependencies and default integration with other tools

## Odig

[Odig](http://erratique.ch/software/odig) is a library and command-line tool to mine installed OCaml packages. It supports package distribution documentation and metadata lookups, and generates cross-referenced API documentation with ocamldoc and/or odoc.

## Previous Incarnations

### Codoc

An alpha version of [Codoc](https://github.com/dsheets/codoc) was published in 2014. The documentation tool was designed to eventually replace ocamldoc, and had an impressive [wishlist of features](http://opam.ocaml.org/blog/codoc-0-2-0-released/). Despite not being fully feature complete it is usable, you can view the [output](http://dsheets.github.io/codoc/), and it forms the basis for our new documentation generation system.

----

{% include news.html name="documentation" %}
