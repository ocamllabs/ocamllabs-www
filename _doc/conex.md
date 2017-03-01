---
authors: [gemmag, avsm, kc, yallop]
title: "Conex"
layout: page
---

The purpose of Conex is to enable a secure distribution of OCaml packages by establishing digital signatures. The original author signs their package release and build instructions, the client then verifies the signature - neither the server hosting the repository nor the server where the packages are downloaded from need to be trusted.

Conex has been designed with opam in mind, but it is an independent system which can be used to update any data in an authenticated manner.

{% include news.html name="conex" %}
