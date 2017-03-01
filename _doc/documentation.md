---
authors: [gemmag, avsm, kc]
title: "Documentation"
layout: page
---

We've been working on a collection of tools to automatically generate useful and usable OCaml documentation for ~3 years, with each iteration along the way getting us closer and closer. Our current system now provides automatically generated documentation for a fully interlinked set of modules, all organised in a convenient and user-friendly way.

The system is currently in beta, and you can view the [output for the MirageOS central documentation repository](http://docs.mirage.io/). Please report [issues upstream](https://github.com/ocaml-doc/odoc/issues), and provide other feedback as necessary.

The system seeks to:

- cover all of OCaml's language features
- provide accurage name resolution and linking
- support cross-linking between packages
- reduce external dependencies and default integration with other tools

{% include news.html name="documentation" %}
