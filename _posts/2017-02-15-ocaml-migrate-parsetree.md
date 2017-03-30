---
title: Making PPXs Portable with ocaml-migrate-parsetree
layout: post
author: let-def
category: Projects
tags: ppx
---

An effort to make PPXs portable across compiler versions.

PPX extensions work by receiving a syntax tree from the compiler, rewriting it, and sending it back. Extensions obtain the definition of the syntax tree as well as some helpers from compiler-libs. Thus they tend to depend on the internal of the compiler.

PPX developers often have to maintain separate code for each version of the compiler they want to support. When a new compiler version is introduced, most opam packages are unavailable because of PPX breakage.

To address these two problems [ocaml-migrate-parsetree](https://github.com/let-def/ocaml-migrate-parsetree) versions the syntax tree and provides conversion functions.
Migrating to a new version always succeeds, migrating to an older version fails if some features in use are not available.

Versions covered are 4.02, 4.03, 4.04 and trunk (4.05). A code working with 4.04 will work out of the box on 4.05. However, if the code later evolves to make use of 4.05 specific features, it will no longer be backwards compatible.

Features provided by `ocaml-migrate-parsetree` includes:
- versioning of `Asttypes`, `Parsetree`, `Ast_helper`, `Outcometree` and parts of `Ast_mapper` and `Docstrings`
- unmarshalling of any supported versions of syntax trees
- conversion of parsetrees and lifting of `Ast_mapper.mapper` between arbitrary versions.

For `Ast_mapper` and `Docstrings`, anything relying on global state has been removed. Lifting of `Ast_mapper.mapper` breaks the open recursion (the Ast is converted to the targeted version only once when entering the mapper and converted back when leaving).

## Minimal guide to porting a PPX extension

Porting is easy as long as you stick to modules that are versioned by _ocaml-migrate-parsetree_. It is trivial if you make direct use of `Ast_mapper`. However using `Ast_mapper_class` from [ppx_tools](https://github.com/alainfrisch/ppx_tools) breaks this approach.

Starting from a PPX written against OCaml 4.04, porting amounts to:

```ocaml
(* Shadowing compiler-libs modules with the ones versioned for 4.04 *)
open Migrate_parsetree
open Ast_404

... (* your ppx code *)

(* ########################################### *)
(* Registering the mapper with the host version of compiler-libs

   Original code:
   let () =
     Ast_mapper.run_main @@ fun _ -> my_mapper
*)

(* Create a module converting structures from 4.04 to current version *)
module To_current = Convert(OCaml_404)(OCaml_current)

let () =
  (* Original Ast_mapper is shadowed.
     Compiler_libs module provides aliase to the original one. *)
  Compiler_libs.Ast_mapper.run_main @@ fun _ ->
  (* Finally lift the mapper *)
  To_current.copy_mapper my_mapper

(* ########################################### *)
(* Alternatively, if the implementation uses Ast_mapper.register:

   let () = Ast_mapper.register "my_mapper" mapper
*)

let () =
  let module To_current = Convert(OCaml_404)(OCaml_current) in
  Compiler_libs.Ast_mapper.register "my_mapper" (To_current.copy_mapper mapper)
```

## Future work

While a few PPX extensions have already been ported, the ones relying on `Ast_mapper_class` are not handled yet. Porting more of them and agreeing on a reasonable set of features to cover most use cases is a prerequisite before a 1.0 release.

Another axis is the handling of unsupported features. As of today, converting an unsupported feature raises an exception. Some PPX extensions could opt-in a softer policy of encoding new constructions as attributes. This make sense when using an old PPX with a new version of the compiler.
