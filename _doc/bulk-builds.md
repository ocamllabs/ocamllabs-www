---
authors: [gemmag, avsm, kc]
title: "Bulk Builds"
layout: page
---

As the Opam package database grows beyond 3000 packages, we need automated ways of building each package. This requires not only an OCaml and Opam installation, but also some sandboxing techniques to install external dependencies. For Linux, we are using the [Docker](https://www.docker.com/) container manager to perform these [builds](https://github.com/avsm/ocaml-dockerfile). The [logs from the bulk builds](http://www.recoil.org/~avsm/opam-bulk/) are then collected via the [Irmin](https://github.com/mirage/irmin) database in order to be classified and rendered to a webpage.

**NOTE** This a purely Linux-only solution currently. While it lets us test various distributions such as CentOS, Debian, Ubuntu and RHEL, we still need other solutions for MacOSX, Free/Net/OpenBSD and Windows. The situation will hopefully ease as the upstream Docker support for non-Linux platforms matures.

{% include news.html name="bulk" %}
