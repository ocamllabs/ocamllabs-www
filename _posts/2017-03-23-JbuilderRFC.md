---
title: Composable Builds for OCaml with Jbuilder
layout: post
author: gemmag
category: RFC
tags: build packaging platform mirage janestreet topkg opam odoc documentation
---

Jane Street have just [released](https://github.com/ocaml/opam-repository/pull/8770) [Jbuilder](https://github.com/janestreet/jbuilder) - a composable build system for OCaml projects that allows you to build batches of libraries together while creating a smooth and consistent user experience.

Jbuilder is currently in beta testing stage. Please see the [roadmap](https://github.com/janestreet/jbuilder/blob/master/ROADMAP.org) and [manual](https://github.com/janestreet/jbuilder/blob/master/doc/manual.org) for further details and for information on how to provide feedback.

Within the context of MirageOS, there is discussion about how the ecosystem can utilise Jbuilder in combination with existing tools from the [OCaml Platform](http://ocamllabs.io/doc/platform.html), and how to approach an end-to-end scenario that takes advantage of these new features. Join the conversation [here](https://github.com/mirage/mirage/issues/818).
