---
title: testing ocaml-migrate-parsetree with `ppx_deriving_crowbar`
layout: post
author: yomimono
category: General
tags: ocaml fuzzing afl crowbar ppx tooling testing platform
---

# testing ocaml-migrate-parsetree with `ppx_deriving_crowbar`

[Early feedback](https://github.com/stedolan/crowbar/issues/7) on Crowbar suggested that some automated method of constructing generators might be useful.  It wasn't necessary to do this immediately for [the demonstration of testing the OCaml standard library's Map and Set functors](https://github.com/yomimono/ocaml-test-stdlib) with Crowbar, but what about more complicated types?  Like, say, the complicated and heavily mutually recursive types that compose [OCaml parsetrees](https://github.com/ocaml/ocaml/blob/trunk/parsing/parsetree.mli)?

With an eye to solving this problem, I looked into a few options and finally settled on using [ppx_deriving](https://github.com/ocaml-ppx/ppx_deriving).  `ppx_deriving` is "a library simplifying type-driven code generation", and not just for the author of an automatic code-generating tool, but also for the user who might wish to use such tools, or the maintainer who wants to be sure that multiple tools can be used together easily.  Using `ppx_deriving`, one can annotate a type `t`:

```
type t = {
  a : int;
  b : Parsetree.core_type;
} [@@deriving myplugin]
```

and `myplugin` will have a chance to generate code based on the structure of `t`.

I was able to create such a tool for Crowbar, creatively named [ppx_deriving_crowbar](https://github.com/yomimono/ppx_deriving_crowbar).  The plugin is still in an experimental state, but mostly fulfills the requirements for `ppx_deriving` plugins set out in that project's README.  It is capable of making generators for [OCaml 4.05 parsetrees](https://github.com/yomimono/ocaml-test-omp/blob/primary/test/parsetree_405.ml) and certificates for the [x509 library](https://github.com/mirleft/ocaml-x509), and probably much more!
