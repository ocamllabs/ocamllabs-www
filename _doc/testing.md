---
authors: [gemmag, avsm, kc]
title: "Automated Test Infrastructure"
layout: page
---

There are a few areas around testing OCaml that we are working on:

* [Continuous Integration]({% link _doc/ci.md %}) against GitHub repositories.
  * Docker containers: these contain all the permutations of OCaml, OPAM and Linux distributions for automated matrix testing.  See [ocaml/opam](https://hub.docker.com/u/ocaml) on the Docker Hub for the OCaml and OPAM containers.
* Performance and regression testing for OCaml (TODO)dd

----

{% include news.html name="testing" %}
