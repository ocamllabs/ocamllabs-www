---
title: MirageOS 3.0.0 Released!
layout: post
author: gemmag
category: Releases
tags: mirage platform odoc topkg opam libraries
---

The release of [Mirage 3.0.0](https://mirage.io/) brings further flexibility and stability to the modular operating system, together with improved user and developer experience. The core team has focussed on improving development workflow, providing easier interfaces and interoperability where possible, with collaboration from a growing user base employing MirageOS components in production and research.

You can see the [main announcement](https://mirage.io/blog/announcing-mirage-30-release) for details, but a summary of new features includes: 

* [Solo5](https://github.com/solo5/solo5/tree/master/README.md) integration allowing for easier unikernel deployment
* Smooth interoperability with [OPAM](https://opam.ocaml.org/), including management of external library dependencies
* Automatically generated, interlinked [module documentation](http://docs.mirage.io/)
* Module types for reporting errors
* Logging improvements
* Build system shift using [`topkg`](http://erratique.ch/software/topkg/doc/Topkg.html#basics)
* Leaner codebase

Contribution from OCaml Labs comes in the form of [Platform](http://ocamllabs.io/doc/platform.html) improvements, specifically documentation infrastructure, package distribution with `topkg`, and other OCaml tooling and libraries.

The release of 3.0.0 involves a huge amount of work from a growing MirageOS community, resulting in more compact but flexible applications that run as self-contained virtual machines - it’s now easier than ever to use MirageOS: get started [here](https://mirage.io/wiki/hello-world)!
