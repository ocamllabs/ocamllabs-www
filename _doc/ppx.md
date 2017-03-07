---
authors: [avsm]
title: "PPX"
layout: page
---

The [PPX](http://caml.inria.fr/pub/docs/manual-ocaml-4.02/extn.html#sec243) language feature provides a new API for syntactic extensions in OCaml. PPX uses attributes to allow type-driven code generation, extension nodes for custom constructs and quoted strings for insertion of code fragments in unrelated syntax.  There are some useful [ppx_tools](https://github.com/alainfrisch/ppx_tools) developed by Lexifi that make working with PPX easier.  They have the following ocamlfind libraries if you `opam install ppx_tools`:

**`ppx_metaquot`**

A ppx filter to help writing programs which manipulate the Parsetree, by allowing the programmer to use concrete syntax for expressions creating Parsetree fragments and patterns deconstructing Parsetree fragments. See the top of ppx_metaquot.ml for a description of the supported extensions.

Usage:

 `ocamlfind -c -package ppx_tools.metaquot my_ppx_code.ml`

**`rewriter`**

A utility to test ppx rewriters that runs the rewriter on user-provided code and returns the result.

Usage:

 `ocamlfind ppx_tools/rewriter ./my_ppx_rewriter sample.ml`

See the integrated help message for more details:

 `ocamlfind ppx_tools/rewriter -help`

**`Ast_mapper_class`**

This module implements an API similar to Ast_mapper from the compiler-libs, i.e. a generic mapper from Parsetree to Parsetree implementing a deep identity copy, which can be customized with a custom behavior for each syntactic category. The difference with Ast_mapper is that Ast_mapper_class implements the open recursion using a class.

**`dumpast`**

This tool parses fragments of OCaml code (or entire source files) and dump the resulting internal Parsetree representation. Intended uses:

* Help to learn about the OCaml Parsetree structure and how it corresponds to OCaml source syntax.
* Create fragments of Parsetree to be copy-pasted into the source code of syntax-manipulating programs (such as ppx rewriters).

Usage:

 `ocamlfind ppx_tools/dumpast -e "1 + 2"`

The tool can be used to show the Parsetree representation of small fragments of syntax passed on the command line (-e for expressions, -p for patterns, -t for type expressions) or for entire .ml/mli files. The standard -pp and -ppx options are supported, but only applied on whole files. The tool has further option to control how location and attribute fields in the Parsetree should be displayed.

**`genlifter</code`**

This tool generates a virtual "lifter" class for one or several OCaml type constructors. It does so by loading the .cmi files which define those types. The generated lifter class exposes one method to "reify" type constructors passed on the command-line and other type constructors accessible from them. The class is parametrized over the target type of the reification, and it must provide method to deal with basic types (int, string, char, int32, int64, nativeint) and data type builders (record, constr, tuple, list, array). As an example, calling:

 `ocamlfind ppx_tools/genlifter -I +compiler-libs Location.t`

produces the following class:

 `class virtual ['res] lifter =
   object (this)
     method lift_Location_t : Location.t -> 'res=
       fun
         { Location.loc_start = loc_start; Location.loc_end = loc_end;
           Location.loc_ghost = loc_ghost }
          ->
         this#record "Location.t"
           [("loc_start", (this#lift_Lexing_position loc_start));
           ("loc_end", (this#lift_Lexing_position loc_end));
           ("loc_ghost", (this#lift_bool loc_ghost))]
     method lift_bool : bool -> 'res=
       function
       | false  -> this#constr "bool" ("false", [])
       | true  -> this#constr "bool" ("true", [])
     method lift_Lexing_position : Lexing.position -> 'res=
       fun
         { Lexing.pos_fname = pos_fname; Lexing.pos_lnum = pos_lnum;
           Lexing.pos_bol = pos_bol; Lexing.pos_cnum = pos_cnum }
          ->
         this#record "Lexing.position"
           [("pos_fname", (this#string pos_fname));
           ("pos_lnum", (this#int pos_lnum));
           ("pos_bol", (this#int pos_bol));
           ("pos_cnum", (this#int pos_cnum))]
   end`

dumpast is a direct example of using genlifter applied on the OCaml Parsetree definition itself. ppx_metaquot is another similar example.

## Notes on using PPX

OCaml 4.02 and OCaml 4.03 introduce the PPX system to replace [Camlp4](https://github.com/ocaml/camlp4).  Some notes on using it:

* [Extension nodes in the OCaml manual](http://caml.inria.fr/pub/docs/manual-ocaml-4.02/extn.html#sec243)
* [A guid to using extensoin points in OCaml](http://whitequark.org/blog/2014/04/16/a-guide-to-extension-points-in-ocaml/)
* [Extension points, or how OCaml is becoming more like LISP](https://blogs.janestreet.com/extension-points-or-how-ocaml-is-becoming-more-like-lisp/)
* [Converting a code bas from Camlp4 to PPX](https://blogs.janestreet.com/converting-a-code-base-from-camlp4-to-ppx/)

Older posts but of interest:

* [Syntax extensions without Campl4: Part 1](http://www.lexifi.com/blog/syntax-extensions-without-camlp4)
* [Syntax extensions without Camlp4: Part 2](http://www.lexifi.com/blog/syntax-extensions-without-camlp4-lets-do-it)
* [Extension points for OCaml (OCaml Workshop 2013)](https://ocaml.org/meetings/ocaml/2013/slides/white.pdf)
* [wg-camlp4 disussion list, Jan 2013](http://lists.ocaml.org/pipermail/wg-camlp4/2013-January/thread.html)

## FAQ

**Q:** What is the migration path of packages from Camlp4 to ppx?

**A:** There are three OCaml compiler versions to consider:

* OCaml 4.01 and lower: only Camlp4 is available, and no PPX
* OCaml 4.02: Camlp4 is an external package and PPX is available
* OCaml 4.03: Camlp4 is an external package and PPX is available with the 4.03 AST (different from 4.02 AST)

The Jane Street `sexplib` package (and related ones) used to be Camlp4 only, and then after the 113.09.00 release [shifted to using PPX](https://github.com/ocaml/opam-repository/blob/master/CHANGES.md).  This, when combined with the fact that they only support OCaml 4.02 in recent releases makes it very difficult to support all of the OCaml versions for both Camlp4 and PPX.

Therefore MirageOS chose to enforce a minimum OCaml version of 4.02 and push to migrate all the libraries that were using Camlp4 to PPX as quickly as possible.  The most practical way to use PPX is to drop Camlp4 entirely and to depend on OCaml 4.02+.

**Q:** OCaml 4.02 and 4.03 have different AST formats. How do we support both in one package?

**A:** The
[ppx_tools](https://github.com/alainfrisch/ppx_tools) package provides a unified API for many common tasks that work on both 4.02 and 4.03.  Where this is not possible, use some build system support to select the right version of OCaml and have a different AST mapper.  See [ocaml-cstruct](https://github.com/mirage/ocaml-cstruct) in the ppx/ directory for an example of this.

**Q:** How do I run a PPX rewriter over my source code and see the output?

**A:** First install ppx_tools via `opam install ppx_tools` and then call the rewriter package via `ocamlfind ppx_tools/rewriter ./ppx_cstruct.native foo.ml`.  The nice thing about PPX is that each rewriter is a standalone binary, so it's fairly easy to test independently (unlike Camlp4).

----

{% include news.html name="ppx" %}
