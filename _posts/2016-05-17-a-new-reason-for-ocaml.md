---
title: A new Reason for OCaml
layout: page
author: kc
categories: [News]
---

[Reason](/wiki/Reason "wikilink") is a collaborative open source project
released by Facebook today ([HN
thread](https://news.ycombinator.com/item?id=11716975)) - and we are
incredibly excited to be part of it!
[Reason](http://facebook.github.io/reason/) is a new approachable
interface to the OCaml language, with the long-term goal of improving
the developer experience by providing a functional syntax and toolchain
for writing, building and sharing code quickly and easily.

--more--

`ev:youtube| hhY3BCHugnQ |400|right|Reason Demo: Atom|frame`

OCaml
is used widely in large-scale projects by a wide range of
[users](http://ocaml.org/learn/companies.html); within Facebook to build
scalable infrastructure ([Hack](http://hacklang.org/),
[Flow](http://flowtype.org/), and [Infer](http://fbinfer.com/));
providing performance-sensitive applications for [Jane
Street](https://www.janestreet.com/); and a modular system as part of
[MirageOS](/wiki/MirageOS "wikilink"). We are excited to be collaborating on
the Reason project which provides the opportunity to employ the benefits
of OCaml (such as type inference, fast runtime and bare metal
compilation) whilst removing the blockers to progression that have
previously existed.

OCaml presents a strong research-driven (20 years) language base,
pre-existing compilation to Javascript, a thriving ecosystem and a
mature and growing community. Reason builds on these existing strengths
by supplying a syntax familiar to users of Javascript (and other web
programming languages), a powerful editor toolchain and custom REPL.
Javascript is currently the most pervasive web programming language but
can never fully capitalize on static typing in order to improve runtime
performance. Reason aims to utilize valuable features in OCaml and the
package manager OPAM, adding support for popular editors (Merlin support
for Atom) with the larger aim of creating a seamless build environment
with multi-architectural and operating system support.

Reason, OCaml Labs and wider collaboration
------------------------------------------

Reason complements and extends the work of the [OCaml
Platform](/wiki/OCaml_Platform "wikilink") project at [OCaml
Labs](/wiki/Home "wikilink"). Our focus has been on syntax and editor support,
documentation and adding isolated development and testing environments.
These features are part of the initial open-source release of Reason,
and we will continue to contribute to this collaboration.

### Build system

Reason aims to reimagine the build process, and create an integrated
build system. Progress in this area has been made using a combination of
Jenga build rules and containers utilizing the existing OPAM workflow
and features.

[Docker](https://www.docker.com/) containers provide the developer a
sandboxed environment, equipped with all of the development tools,
distributed as a Docker image. This provides the ability to quickly
build, test and deploy applications on multiple architectures and
operating systems, without having to locally install cross-compilers and
manage virtual machines.

[Jenga](https://github.com/janestreet/jenga) is an expressive and
scalable build system used in production at [Jane
Street](https://www.janestreet.com/), and Atom support for Reason is
built using Jenga and [js\_of\_ocaml](http://ocsigen.org/js_of_ocaml/).
We envisage a build experience that combines Atom, Docker containers and
Jenga to provide sandboxed builds, automatic namespacing and
autogeneration of Merlin files.

### Opam local

The `opam local` project's goal is to enable developers to create
isolated development and testing environments for their OPAM packages.
Associating a switch with a directory via the `opam local create`
command overrides the globally-configured switch, ensuring that
associated commands are then isolated to that switch and directory, thus
leaving the global [OPAM](/wiki/OPAM "wikilink") state unchanged. Developers
can access development lifecycle events defined in their project's OPAM
files via the \`opam package \[build|test|doc\]\` commands. PRs for this
feature are awaiting review:

-   [Local subcommand](https://github.com/ocaml/opam/pull/2550)
-   [Package subcommand](https://github.com/ocaml/opam/pull/2551)

### Merlin

[Merlin](/wiki/Merlin "wikilink") provides semantics-driven editing features
for OCaml in Vim and Emacs. A Reason frontend has been developed to edit
Reason files and report information in Reason syntax. An
[Atom](https://atom.io/)/[Nuclide](http://nuclide.io/) integration
enhances the Reason editing experience with features such as context
sensitive completion, jumping to definition and reporting of type
information and errors.
<img src="Reason_documentation_image.png" title="fig:Redoc" alt="Redoc" width="275" />

### Rtop and OCaml 4.03 support

Keeping Reason up-to-date with OCaml, we contributed to 4.03 syntax
support for Reason, modifying the OCaml printer to build Reason with
4.03. We contributed to `rtop` (a REPL for Reason, an extension of the
powerful `utop`) to print results in Reason syntax, rather than OCaml.
We also added the ability to easily switch between Reason and OCaml mode
in `rtop` with the `#toggle_syntax` directive.

### Reason Documentation

To ensure high interoperability between OCaml and Reason, documentation
is key. `Redoc` is a tool to generate html documentation in Reason
syntax from OCaml sources. It wraps `ocamldoc` by adding a custom html
generator for printing in Reason syntax. Example: [Reason documentation
of OCaml standard
library](http://kcsrk.info/reason_stdlib_docs/Docstrings.html). Ongoing
work with `odoc` from Jane street will further support this feature.

What's Next?
------------

An ongoing project at OCL that is gathering pace is to add
[multicore](/wiki/Multicore "wikilink") as a native feature to OCaml, and by
extension Reason. Concurrency and parallelism as first class citizens
allow asynchronous programs to be written in direct style, employed over
multiple cores, avoiding "callback hell". Native multicore support will
further aid the building and testing of the next generation of web
applications. Other projects include foreign function bindings to
provide seamless integration with libraries written in C (via
[Ctypes](/wiki/Ctypes "wikilink")) and Javascript, and debugging support.
Within the Computer Laboratory we are excited about the potential of
using Reason as a teaching aid, and this is something we are keen to
explore with students and outreach groups.
