---
authors: [gemmag, avsm, kc, yallop]
title: "Ctypes"
layout: page
---

[Ctypes](https://github.com/ocamllabs/ocaml-ctypes) is a library for binding to C libraries using pure OCaml. The primary aim is to make writing C extension as straightforward as possible. The current foreign function interface (FFI) in OCaml is low-level and difficult to use correctly, so we're keen to improve the ease-of-interoperability via the OCaml Platform.

The core of ctypes is a set of combinators for describing the structure of C types: numeric types, arrays, pointers, structs, unions and functions. You can use these combinators to describe the types of the functions that you want to call, then bind directly to those functions - all without writing or generating any C!

## Further Reading

* Ctypes [README](https://github.com/ocamllabs/ocaml-ctypes/blob/master/README.md) and [wiki](https://github.com/ocamllabs/ocaml-ctypes/wiki)
* [Chapter 19: Foreign Function Interface](https://realworldocaml.org/v1/en/html/foreign-function-interface.html) of [Real World OCaml](https://realworldocaml.org/v1/en/html/index.html)
* Blog: [Modular Foreign Function Bindings](https://mirage.io/blog/modular-foreign-function-bindings) in the context of [MirageOS](https://mirage.io/)
* Blog: [Type-safe C bindings using ocaml-ctypes and stub generation](http://simonjbeaumont.com/posts/ocaml-ctypes/) introduces the Cstubs interface
* Tutorial: [Using Cstubs_structs](https://github.com/ocamllabs/ocaml-ctypes/blob/master/examples/cstubs_structs/README.md) provides details on how to use the module to reliably determine data layout

---

{% include news.html name="ctypes" %}
