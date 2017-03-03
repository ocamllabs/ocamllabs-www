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

## Past Project Features

### Codoc: 2014-2015

An alpha version of [Codoc](https://github.com/dsheets/codoc) was published in 2014. The documentation tool was designed to eventually replace ocamldoc, and had an impressive [wishlist of features](http://opam.ocaml.org/blog/codoc-0-2-0-released/). Despite not being fully feature complete it is usable, you can view the [output](http://dsheets.github.io/codoc/), and it forms the basis for our new documentation generation system.

### OPAMDoc: 2013

The OCaml toolchain has shipped with the [ocamldoc](https://github.com/ocaml-doc) tool for a long time - it runs over a single OCaml library and generates cross-referenced documentation.  It also supports a variety of outputs, such as Latex, HTML, PDF and even manpages. However, it is starting to show its age for large, complex codebases such as [Core](http://github.com/janestreet/core), and so we are developing a more scalable alternative for the Platform effort.

OPAM-doc consists of two separate commands:

* [bin-doc](http://github.com/ocamllabs/bin-doc) is a replacement for the OCamldoc lexer (which extracts documentation from [source code comments](http://caml.inria.fr/pub/docs/manual-ocaml-4.00/manual029.html)). It uses the OCaml-4.00+ facility for generating .cmt files that contain the typed AST, and generates .cmd files which contain the documentation information. By using a separate file from the AST, we leave open the possibility of having multiple language translations in the future. These .cmd and .cmdi files can be combined with the .cmt files to generate complete documentation directly from the output of the compiler. This command is intended to be temporary, and can be integrated into the upstream in the future.

* [opam-doc](http://github.com/ocamllabs/opam-doc opam-doc) takes a set of cmt and cmd files and outputs a single JSON representation of all the files. This JSON can then be post-processed (or directly rendered in Javascript) to create a single documentation repository that reliably renders cross-references across entire libraries. Thus, the entire Platform can have one documentation source rather than having to search across packages.

The ultimate aim is to support the OCaml platform with interactive tutorials using the
[js_of_ocaml](http://ocsigen.org/js_of_ocaml) compiler. You can try out the prototype of this in OPAM via `opam install opam-doc &&; opam doc core async`. It will start a local webserver on which you can browse the traffic. There is also a snapshot available on [the Mirage documentation](http://mirage.github.io).

----

{% include news.html name="documentation" %}
