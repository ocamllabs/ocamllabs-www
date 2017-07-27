---
title: A New Implementation of Git
layout: post
author: gemmag
category: RFC
tags: ocaml git ocamlgit irmin mirageos mirage ecosystem tooling http serialisation pack sirodepac faraday angstrom farfadet decompress digestif
---

Displaying his own true sense of style, Romain Calascibetta added an incredibly detailed (and hilariously funny) PR for integrating his new Git implementation into [`ocaml-git`](https://github.com/mirage/ocaml-git) - using the new implementation!

For the last ~6 months, Romain has been working hard to improve `ocaml-git`: decoding/encoding PACK files; implementing the `git gc` command; `git push`; and HTTP protocol.

He is currently integrating this work into the existing `ocaml-git` implementation using a bottom-to-top method, and as the new additions will break compatibility, he's asked for community involvement to help decide aspects of the API and forward development.

If you want to know more about "the mystery of the chocolate", read the [full PR](https://github.com/mirage/ocaml-git/pull/227) and contribute your thoughts!

----
