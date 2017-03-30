---
authors: [yallop, lpw25]
title: "Open Types"
layout: page
---

One open type already exists within OCaml: the `exn` type used for exceptions. This project extends this mechanism to allow the programmer to create their own [open types](https://github.com/lpw25/ocaml-open). This has previously been proposed for functional languages a number of times, for instance as part of a solution to the expression problem ([Open Data Types and Open Functions](http://www.cs.ox.ac.uk/ralf.hinze/publications/PPDP06.pdf)). Unlike "exn", these [extensible types](https://sites.google.com/site/ocamlopen/) can have type parameters, allowing for extensible GADTs.

For example:

 `type foo += A`

 `type foo += B of int`

 ``let is_a x =
  match x with
    A -> true
  | _ -> false``

This feature was merged upstream into OCaml 4.02 and is now available as standard. To try it with OPAM if you have an older system compiler, just do `opam switch 4.02.1`. Work was carried out initially between Oct 2012 - May 2014.

----

{% include news.html name="open-types" %}

----
