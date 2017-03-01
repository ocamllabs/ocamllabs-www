---
authors: [gemmag, avsm, kc]
title: "The OCaml Platform"
layout: page
---

The focus of the OCaml Platform is to improve the tooling around packaging, build and test infrastructure. Once complete, this will enable us to effectively run over hundreds of community packages and determine selection criteria for the Platform. A key aspect of this selection will be which libraries are already popular and in use, and also how actively maintained and portable they are across different operating systems.

Broadly, the Platform can be separated into tooling infrastructure for the following phases:

### Build, Package and Release

* [Merlin IDE integration](/doc/merlin.html)
* [Opam package management]({% link _doc/opam.md %})
* [OCaml Documentation]({% link _doc/documentation.md %})
* Packaging libraries: Topkg, Odig
* Docker automatic builds

### Test

* [Continuous Integration and Testing]({% link _doc/testing.md %})

### Maintenance and Improvement

* [Digital signing with Conex]({% link _doc/conex.md %})

### Popular libraries

* [Ctypes]({% link _doc/ctypes.md %})

{% include news.html name="platform" %}
