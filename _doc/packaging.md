---
authors: [gemmag, avsm, kc, dbuenzli]
title: "Packaging Workflow"
layout: page
---

Packaging workflow refers to the processes involved with packaging and releasing software, and we are striving to reduce the publishing, release and maintenance burdens by making the workflow as efficient, swift, robust and painless as possible.

* `topkg`

[Topkg](http://erratique.ch/software/topkg) is a packager for distributing OCaml software published by [Daniel Bünzli](http://erratique.ch/contact.en). It provides an API to:
- describe the files a package installs in a given configuration
- specify information about the package's distribution creation and publication procedures.

It is a library that is added as a build dependency to your package, and comes with an optional topkg-care tool which helps you manage your package lifecycle.

You can read the [full documentation](http://erratique.ch/software/topkg/doc/Topkg.html#basics), and also the [rationale](http://ocamllabs.io/projects/2017/02/23/topkg.html) behind its creation.

* `odig`

[Odig](http://erratique.ch/software/odig) is a library and command-line tool to mine installed OCaml packages. It supports package distribution documentation and metadata lookups, and generates cross-referenced API documentation with `ocamldoc` and/or `odoc`.

## Previous Incarnations

### Assemblage

The Assemblage project was initiated to setup, manage and use OCaml projects - a toolbox library to provide and API and a minimum set of binaries and libraries with precise (and static) dependency relationships.

There wasn't a public release, and much of the thought behind the initial design has since been channelled into `topkg` and associated libraries.

{% include news.html name="packaging" %}
