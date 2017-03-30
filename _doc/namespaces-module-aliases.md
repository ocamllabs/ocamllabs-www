---
authors: [avsm, mshinwell, lpw25]
title: "Namespaces and Module Aliases"
layout: page
---

Namespaces provide a means for grouping the components of a library together.

Up to now this has been achieved using the OCaml module system. Since the components of an OCaml library are modules, a module can be created that contains all the components of the library as sub-modules. However, there are some critical problems with creating a single module containing the whole library:

* The module is a single unit that has to be linked or not as a whole. This means that any program using part of the library must      include the entire library.
* The module is a choke-point in the dependency graph. If a file depends on one thing in the library then it needs to be recompiled if anything in the library changes.
* Opening a very large module is slow and can seriously affect build performance.

These problems are caused by the runtime semantics of modules. Namespaces have no runtime semantics and could provide a solution to these problems.

While the namespaces feature continues to be refined, support for type-level [module aliases was added to the OCaml 4.02 compiler](https://caml.inria.fr/pub/docs/manual-ocaml/extn.html#sec235). This is a trivial extension of the ML module system that helps to avoid unnecessary code dependencies, and provides an alternative to strengthening for type equalities.

This feature was initially discussed Feb 2013 - Sep 2014.

- Blog: [Better namespaces through module aliases](https://blogs.janestreet.com/better-namespaces-through-module-aliases/)
- Blog: [Adding namespaces to OCaml](http://www.lpw25.net/2013/03/10/ocaml-namespaces.html)
- Mailing List: [On the need for and design of OCaml namespaces](http://lists.ocaml.org/pipermail/platform/2013-February/000050.html)

----

{% include news.html name="namespaces" %}

----
