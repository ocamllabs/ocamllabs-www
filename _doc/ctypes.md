---
authors: [gemmag, avsm, kc, yallop]
title: "Ctypes"
layout: page
---

Ctypes is a library for binding to C libraries using pure OCaml. The primary aim is to make writing C extension as straightforward as possible. The current FFI in OCaml is low-level and difficult to use correctly, so we're keen to improve the ease-of-interoperability via the OCaml Platform.

The core of ctypes is a set of combinators for describing the structure of C types: numeric types, arrays, pointers, structs, unions and functions. You can use these combinators to describe the types of the functions that you want to call, then bind directly to those functions - all without writing or generating any C!

{% include news.html name="ctypes" %}
