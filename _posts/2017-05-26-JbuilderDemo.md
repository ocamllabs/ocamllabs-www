---
title: "Why Jbuilder? Demonstration and Discussion"
layout: post
author: gemmag
category: Events
tags: ocaml events community outreach opensource teaching jbuilder build platform tooling
---

Yesterday we welcomed attendees from [Docker](http://docker.com), [Microsoft Research](https://www.microsoft.com/en-us/research/lab/microsoft-research-cambridge/) (MSR), [Barclays](http://www.barclays.co.uk/PersonalBanking/P1242557947640), OCaml Labs, [Jane Street](https://www.janestreet.com/) and [Citrix](https://www.citrix.co.uk/#ctx-nav) to a Jbuilder discussion and demonstration. This is the first informal Tech Talk of a possible future series at Docker, and we experimented with [live remote access and video recording](https://discuss.ocaml.org/t/cambridge-jbuilder-demo-discussion-may-25th/195/9). Huge thanks to the Docker team for providing the venue and Zoom!

**Another build system?!**

It's well known that OCaml has more than a few existing build systems and associated tools (ocamlbuild, jenga, omake, oasis) so why add [Jbuilder](https://github.com/janestreet/jbuilder)? [Jérémie Dimino](https://github.com/diml) reassured us that Jane Street don't just *really* enjoy writing build systems, but Jbuilder exists to provide an easy-to-use build system for general and portable use. Jeremie works on open source development at Jane Street London with [Mark Shinwell](https://github.com/mshinwell), [Thomas Refis](https://github.com/trefis) and [Leo White](https://github.com/lpw25), and his talk covered some background on how Jane Street develops and releases open source tooling, with details of the origin of Jbuilder and its features.

{% include thumb.html name="JbuilderDemo.jpg" pos="right" alt="Anil introduces Jérémie" %}

This post touches on the motivations for creating [Jbuilder](https://github.com/janestreet/jbuilder) and looks at some of its main features. For more detailed technical information on the tool itself, please check out the [video](https://www.youtube.com/watch?v=xGf_NCZUios), slides and [GH documentation](https://github.com/janestreet/jbuilder) and [manual](http://jbuilder.readthedocs.io/en/latest/).

### Open Source in an Industrial Setting

Jane Street uses a [monolithic repository](https://github.com/janestreet) for their entire codebase, and operates with a continuous release process. In order to create a smooth development workflow they create in-house tooling, to work in the specific context of their requirements and environment. In contrast to this context-specific, industry-led process, the wider world of open source consists of lots of small repositories that are maintained by a variety of individuals and entities, complex version constraints, and often disparate tools and libraries that don't necessarily form a cohesive whole. For example, building a project in OCaml requires interaction with ocamlfind, ocamlbuild, [topkg](https://github.com/dbuenzli/topkg), oasis, [opam](https://github.com/ocaml/opam) - with different interfaces, portability constraints and extension mechanisms for each of these tools.

The open source team at Jane Street London released their first library [sexplib](https://github.com/janestreet/sexplib), 4 years ago, and hundreds of [other libraries](https://github.com/janestreet?page=1) have followed, with their packages being relied on more and more. The public release process in Jane Street requires splitting the monorepo "Jane" into it's constituent individual libraries e.g. "Async", ["Core"](https://github.com/janestreet/core) and ["Sexplib"](https://github.com/janestreet/sexplib), followed by set up of these repositories. This includes various stages of setup such as license.txt, _oasis.setup.ml, myocamlbuild.ml, _tags, META files, install.ml and and an opam file. This process requires extensive, painful manual adjustment depending on the specific project and its tooling interactions, and the result is a collection of tools that don't understand each other, creating a system that becomes impossible to understand.

Jeremie noted the common occurrence that if there is a system that a developer doesn't understand, they will simply write layers around it to make it work in a way they do understand. Keen to avoid this, the team realised this was an opportunity to address the issues directly, and to further merge the different worlds of industrial open source in Jane Street, and public open source.

### Jbuilder and Jenga

In order to fully understand Jbuilder, we first need to look to Jenga. [Jenga](https://github.com/janestreet/jenga) is a fully-featured build system used internally at Jane Street used on a large scale with their huge monorepo (huge = 1 million lines of code/100,000 files), that supports polling builds and interacts with Emacs. Jenga was created 4 years ago to replace a massive omake file that had become incredibly difficult to work with, and over the last 4 years Jenga has been continually improved and developed as the codebase grows. It has a dedicated team of build system admins that maintain it Jenga and the Jenga rules.

Jenga is too large for a public release, and far too specific to the internal environment at Jane Street which is purposefully scaled for their huge codebase and repository. Instead of trying to bootstrap Jenga to become more portable, or using makefiles to build projects, Jeremie decided to use the schema component of Jenga - the [Jenga Rules](https://github.com/janestreet/jenga-rules) - and make them more generalisable to work with more systems.

{% include thumb.html name="JbuilderBotanics.jpg" pos="right" alt="A walk through the Botanic Gardens post demo" %}

**Essentially, Jbuilder = Jenga Rules - Jenga.**

### JBuilder Specific Features

Jbuilder takes care of the usual build system requirements such as compilation of libraries, executables and documentation; setting up tests and development tools etc, but it also has some specific features that differentiate it from the crowd.

**Automatic Discovery**

This feature is imported from Jenga, means that you never need to specify where the libraries/executables are. This means that it's very easy to re-organise projects, as it simply requires renaming the directories. The system applies the same process to local and installed files, which supports multi-project development.

**Build Contexts**

As Jbuilder is composable, it supports multi-package repositories, allowing you to build simultaneously against several switches/roots in Opam, and enabling you to build everything at once. Artifacts are collected in `_build/<context>/`, and the contexts are specific to the rules (Jbuilder API) not part of the core (full build system) - ensuring that only the high-level API details are exposed to the user.

**Cross Compilation**

Since the rules are part of the API, they can cross build contexts. All of the necessary hooks are present to allow the user to tell Jbuilder when you want things on the host or the target.

**And the rest...**

- generates .install files
- supports repositories defining multiple packages
- generates META files
- supports parallel builds
- portable: it works on Windows without cygwin
- tries to report usable error messages

### Future Plans

As with Jenga, Jbuilder is very OCaml-centric. This, and other features could change in the future. Plans include:

* Release 1.0.0 - a full release is currently waiting for:
  - API Documentation
  - Versioning story for jbuild files: don't want to end up in a position where you have minor versions for the files, and simply want it to tell you if you are using a construction that is not supported

* Features supported by Jenga
   - polling builds
   - communication with Emacs

* Bridge with Jenga
  - Refactoring needed to make this possible
  - Need to write a Jenga plugin that reuses the rules

* OCaml plugins
  - Would like to allow complex rules to be written outside of Jbuilder
  - Automatic loading
  - Syntax that makes extensions clear
  - Allow plugins inside the workspace
