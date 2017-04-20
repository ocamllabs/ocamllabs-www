---
title: Using Menhir to Build Grammar Attributes
layout: post
author: let-def
category: Releases
tags: ocaml opam merlin platform menhir
---

[Menhir](http://gallium.inria.fr/~fpottier/menhir/) is a parser generator for OCaml that compiles LR(1) grammar specifications to OCaml code. It is developed by François Pottier and Yann Régis-Gianas.

The new release out this week includes:

* License changed from QPL to GPLv2
* [Public repository](https://gitlab.inria.fr/users/sign_in) on GitLab
* API improvements
* MenhirSdk library

View the details:

* [Main announcement](https://sympa.inria.fr/sympa/arc/caml-list/2017-04/msg00075.html)
* [Full list of changes](https://gitlab.inria.fr/fpottier/menhir/blob/master/CHANGES.md)
* [Documentation manual](http://gallium.inria.fr/~fpottier/menhir/manual.pdf)
* [Download](https://opam.ocaml.org/packages/menhir/) the release from opam

### MenhirSdk

This new library has been added to allow external tools (such as [Merlin](https://github.com/ocaml/merlin)) to interact with Menhir by offering a programmatic interface to consume Menhir datastructures (grammar and automaton, on which specific user attributes can be added).

Originally, Merlin used its own version of Menhir. It added a few fancy things such as recovering from any situation (to always produce an AST), introspecting the state (to understand errors), etc. The changes were quite specific and intrusive, so the next job was to develop a generic infrastructure on top of which these features can be implemented.

The first part was the **incremental** interface, merged two years ago, which exposed parser checkpoints and give the control of the parsing loop to the user. It also provided a limited **introspection** API to make sense of the current state of the parser (for printing purposes). A hard-coded printer implementation was also offered to Menhir users, but it didn't offer much flexibility for customizing the printing.

The next part was to extend the inspection interface and to expose information about the grammar and the automaton. At compile-time, **MenhirSdk** allows to extract information from the grammar and the automaton. At run-time, the extended **MenhirLib** API allows to manipulate the state of the parser in a type safe way.

**Using MenhirSdk with external tools**

The main benefit is that Menhir focuses on the grammar and generates an automaton without being affected by user extensions. Various constructions of the grammar can be given attributes, inspired by PPXs, that Menhir will pass unchanged to the Sdk. The Sdk is just an OCaml library that exposes the grammar, the automaton (and the mapping between both) together with the user attributes.

Some examples demonstrating these possibilities should come later, mostly inspired by the use of MenhirSdk in Merlin.

Extensions being considered:

- `gen_recover`: generates an error resilient parser: at any point in parse you can get an AST, obtained by filling holes in the tree with default values (either manually provided or automatically derived from grammar), or reattach to a later point in the token stream
- `gen_printer`: introspects the content of a parser, displays information about its runtime state and the corresponding grammar part
- `gen_explain`: quick'n'dirty explanation of parse errors
- coverage test: generate sentences that will exercise the grammar
- BNF grammar: generates BNF from a Menhir Grammar (following RFC or TeX conventions)

Related reading:

* [Incremental parsing conversation on Hacker News](https://news.ycombinator.com/item?id=13915150)

----
