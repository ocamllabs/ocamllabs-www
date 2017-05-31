---
title: "A Week of Platform Releases: Odig, Odoc, Opam Bundle and More!"
layout: post
author: gemmag
category: General
tags: ocaml releases community teaching jbuilder build platform tooling documentation opam packages discuss janestreet core
---

[Every year](http://ocamllabs.io/general/2016/06/09/busy-spring-week-2016.html), May and June bring a hive of activity to the Computer Lab, and 2017 is no exception!

Our group is becoming more distributed across the globe, and we've taken extra steps to encourage communication by adopting the open-source Discourse forum for OCaml. The [forum](https://discuss.ocaml.org/) has become very active very quickly, and includes beginner questions, platform discussion and announcements of new releases.

It's always fun bringing together OCaml contributors from all over the world to discuss their projects and ideas, and when possible, just getting everyone in the same physical room is the most effective boost for the progress of a project. This week we are hosting Daniel Bünzli, Jérémie Dimino, Thomas Refis and Frédéric Bour to explore new features they are adding, and also how to tackle future additions to the OCaml platform and wider toolchain.

## Projects and Releases

### Jbuilder and Core Jane Street Packages

* Jbuilder

Jérémie demonstrated the new build system from Jane Street, specifically designed for use with both small and large scale projects, and outlined its future direction. You can view the [recording](https://www.youtube.com/watch?v=xGf_NCZUios), read a [summary](http://ocamllabs.io/events/2017/05/26/JbuilderDemo.html) and view the [manual](http://jbuilder.readthedocs.io/en/latest/) to get more details.

* Jane Street Core

We also collaborated with Jane Street on the release of [Core v0.9.0](https://discuss.ocaml.org/t/v0-9-release-of-jane-street-packages/253/4): one of the biggest releases of their libraries with a total of 94 packages (32 more than the previous release). New packages covered a wide range of areas, such as shell programming, web programming, standard libraries, Emacs hacking and more. All of this was done using the new CI infrastructure developed by OCaml Labs, seen in [#9250](https://github.com/ocaml/opam-repository/pull/9250), [#9187](https://github.com/ocaml/opam-repository/pull/9187) and [#9132](https://github.com/ocaml/opam-repository/pull/9132) in the OPAM repository.

### Documentation with Odig & Odoc

This week's release of Odoc includes OCaml 4.04 support, and documentation of the tool itself will follow soon. Daniel Bünzli released [odig 0.0.2](https://discuss.ocaml.org/t/ann-odig-0-0-2/310), the command line tool to mine installed OCaml packages. Together with mining library APIs, odig also mines package metadata and generates cross-referenced API documentation for opam switches. Features specific to this release include:

* Odoc generated API documentation

Odoc is now the default documentation backend for odig, replacing ocamldoc. Future versions of odig will not support ocamldoc, and we encourage users to compare the output from both tools to aid development. You can check the [odoc output](http://docs.mirage.io/) and [ocamldoc output](http://docs.mirage.io/_ocamldoc/) for MirageOS packages and report issues on the [odoc](https://github.com/ocaml-doc/odoc) tracker.

* Experimental data-driven toplevel loaders

This feature aims to reduce the need for `.ocamlinit` files in your projects, and checks for modules in your build directory/package install base and loads the appropriate dependencies. As titled, it is an experimental feature, and issues are tracked [here](https://github.com/dbuenzli/odig/issues/10).

### Packaging with Opam Bundle

Opam is progressing through a variety of beta releases, and our collaborator Louis Gesbert released [opam-bundle 0.1](https://discuss.ocaml.org/t/ann-opam-bundle-0-1-generate-self-contained-distributable-source-package-bundles/291) for self-contained, distributable source package bundles. This tool downloads all package dependencies and parcels them up into a bundle together with the tarball. You can provide feedback on the [issue tracker](https://github.com/AltGr/opam-bundle/issues) and follow the project progress in the [repository]( https://github.com/AltGr/opam-bundle).

Proposed future features include bundle generation of pinned packages and/or local switch setups.
