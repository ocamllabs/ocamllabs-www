---
authors: [avsm]
title: "Documentation"
layout: page
---

## OCaml Compiler

This refers to the core compiler toolchain, the [OCaml language](https://caml.inria.fr/) and runtime system. Our work includes daily maintenance such as bug fixes and long term improvements to the type system and runtime libraries. We are actively engaging with the wider OCaml community to ensure that improvements and modifications we propose are thoroughly discussed, well-formulated and maintainable. Recent projects include significant work towards multicore support for parallelism and concurrency in OCaml together with greater facilitation for metaprogramming approaches.

Major efforts in this space include:

* [Multicore OCaml](/doc/multicore.html)

## OCaml Platform

The Platform combines the core OCaml compiler with a coherent set of libraries, tools and documentation. We look to large-scale users of OCaml to guide the direction of development in this area, including [Jane Street](https://blogs.janestreet.com/category/ocaml/), [MirageOS](https://mirage.io/), [Docker](https://blog.docker.com/2016/06/docker-mac-windows-public-beta/) and [Facebook](https://github.com/facebook/reason). Recent developments have focussed on the developer experience; tooling improvements around packaging, build and test infrastructure; and support for different operating systems and infrastructures.

* [Merlin IDE integration](/doc/merlin.html)

## MirageOS

[MirageOS](https://mirage.io) is a library operating system written in OCaml that can be used to build unikernels for secure, high-performance network applications across a variety of cloud computing and mobile platforms.

There is a vibrant and growing ecosystem around constructing libraries for MirageOS that are built in pure OCaml with minimal external dependencies - this unlocks that functionality in all of the target architectures that it supports. MirageOS depends on a number of components that are developed and maintained by OCaml Labs.
