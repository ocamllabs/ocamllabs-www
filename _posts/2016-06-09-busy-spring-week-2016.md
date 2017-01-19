---
title: A busy spring week with multicore progress, releases, interns and visitors galore
layout: post
author: gemmag
categories: [News]
---

Spring is an exciting time of year in the lab as we traditionally host a
lot of visitors, hold interesting events, and it provides a great
opportunity to get collaborators to meet and discuss their ideas and
project plans.

This week marked the start of our steady stream of visitors to the lab,
and it was great to welcome both new and well-known faces to Cambridge.
It's been interesting introducing new interns to the existing group, and
watching ideas develop and consolidate over time. It's been a busy few
weeks of new projects starting, new releases and updates to existing
infrastructure, and our [13th compiler hacking
event](http://ocamllabs.github.io/compiler-hacking/2016/05/20/spring-compiler-hacking.html)
at the Old Library in Pembroke College provided the perfect venue and
opportunity to discuss these ideas.

--more--

<img src="Lab_summer.jpg" title="Lab_summer.jpg" alt="Lab_summer.jpg" width="200" />

Internships
-----------

Progress with the internship projects is moving forward nicely, with
Enguerrand close to a Ctypes-TLS implementation, Romain working hard on
MrMime and the deceptively complicated world of parsing email, and
Olivier deep in the compiler with his macros.

-   The libtls-like
    [interface](https://github.com/Engil/ocaml-ctypes-inverted-stubs-tls-prototype)
    for ocaml-tls is now almost complete, the final steps being testing
    the binding against various software from the OpenBSD project.
    Building on the Ctypes project,
    [Enguerrand](/wiki/User%3AEngil "wikilink") is planning to further improve
    the Reason developer experience by focussing on its interoperability
    with C. Exploiting the pre-existing support within OCaml via Ctypes,
    he hopes to extend Reason by generating OCaml bindings which will be
    available in the editor, with Merlin support.

<!-- -->

-   Working with email, specifically multipart and metadata, to ensure
    any implementation is compliant with old and new standards, proves
    to be a long and complicated process, and
    [Romain](/wiki/User%3ADinosaure "wikilink") has been working hard battling
    RFCs and bugs. He now has a prototype to test the implementation of
    [Mr Mime](https://github.com/oklm-wsh/MrMime) and "real world
    email", and is working on pretty-printing.

<!-- -->

-   [Olivier](/wiki/User%3AOlivierNicole "wikilink") is developing the
    [modular
    macros](https://www.cl.cam.ac.uk/~jdy22/papers/modular-macros.pdf)
    work initiated by Jeremy Yallop and Leo White. Macros retain the
    benefits of abstraction, eliminate interpretive overhead, and are
    fully integrated into the OCaml language itself, ensuring generated
    code is well-typed. Olivier has helped to implement module lifting
    which allows the use of compiled external modules in static code,
    and is currently working on the next step of quoting and splicing
    the code.

<!-- -->

-   [Philip Dexter](/wiki/Philip_Dexter "wikilink") from Binghamton University
    joins our growing group of interns for 3 months, to work on a
    reasoning system for approximate computations in OCaml. The system
    builds on the theory work at Binghampton, and will offer static
    error bounds and confidence intervals for computations for which a
    programmer can tolerate approximation. Philip is focussing on
    improving energy optimisation, running unikernels on small ARM
    devices with MirageOS.

<!-- -->

-   [Outreachy](https://www.gnome.org/outreachy/):
    [wiredsis](https://twitter.com/wiredsis) (also known as Gina) is
    taking part in the Outreachy program this year, and is getting stuck
    into OCaml, and the Mirage implementation of Syslog. She writes
    excellent [blog
    posts](http://www.gina.codes/ocaml/2016/06/06/syslog-a-tale-of-specifications.html)
    on her experiences, and expect to see more over the summer.

More details of their implementations, and demos will be available
towards the end of their internship programs.

<small>Our internships are possible thanks to a combination of research
and industrial funding. Romain is funded through the EU FP7 User Centric
Networking project (grant no. 611001)</small>

Releases and Updates
--------------------

-   Native code support for [multicore](/wiki/Multicore "wikilink") is
    [here](https://github.com/ocamllabs/ocaml-multicore/commit/fc366191ff17fffa24aac34fad64c398d462af6d)!
    There is a PR under review to push the multicore branch up to 4.02.2
    to allow for installation of your favourite packages from
    [OPAM](/wiki/OPAM "wikilink"). The goal is to benchmark this new 4.02.2
    multicore version with the standard version.

<!-- -->

-   [Ctypes 0.6](https://ocaml.io/w/Special:ShortUrl/3m) release with
    async FFI support and improved cross compilation.

<!-- -->

-   [Daniel Bünzli](/wiki/Daniel_Buenzli "wikilink") provided us with a
    mass-release and update extravaganza last week, including the
    release of [`topkg`](https://github.com/dbuenzli/topkg),
    [`bos`](https://github.com/dbuenzli/bos) and
    [`fpath`](https://github.com/dbuenzli/fpath) - all designed to work
    together to package and distribute OCaml software more easily and
    efficiently. He also released new updates for
    [`rresult`](https://github.com/dbuenzli/rresult),
    [`fmt`](https://github.com/dbuenzli/fmt/tree/v0.8.0) and
    [`logs`](https://github.com/dbuenzli/logs), much to the delight of
    the community. Daniel is in Cambridge this month to work on a number
    of things, including Windows support for `topkg` and `bos`, and
    upgrades to the Unicode libraries to the new Uchar.t type introduced
    in 4.03 to align with the upcoming 9.0.0 release. Check the
    changelogs for new feature updates for
    [rresult](https://github.com/dbuenzli/rresult/blob/v0.4.0/CHANGES.md),
    [fmt](https://github.com/dbuenzli/fmt/blob/v0.8.0/CHANGES.md) and
    [logs](https://github.com/dbuenzli/logs/blob/v0.6.0/CHANGES.md).

<!-- -->

-   [Frederic Bour](/wiki/Frederic_Bour "wikilink") also joined us for a
    couple of days to talk about the recent improvements and
    implementations for [Merlin](/wiki/Merlin "wikilink"), including the Atom
    integration for [Reason](/wiki/Reason "wikilink"). He's currently working
    on porting Merlin to OCaml 4.03. He also demonstrated his library
    for an interactive text interface using Emacs, which allows you to
    move on from printf-debugging and replay specific parts of the
    program's trace.

