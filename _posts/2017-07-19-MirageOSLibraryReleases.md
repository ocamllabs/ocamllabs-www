---
title: Major Releases of Cohttp, Conduit, DNS and TCP/IP Libraries
layout: post
author: gemmag
category: Releases
tags: ocaml opam mirage mirageos cohttp tcpip conduit jbuilder camlp4
---

Whilst [porting a large portion of Mirage libraries](https://gist.github.com/avsm/9a7ca626f8fe2154525561d9b196ce47) to use [Jbuilder](https://github.com/janestreet/jbuilder), the [MirageOS](https://mirage.io/) core team realised it was also a great opportunity to reorganise the package structure of some specific libraries, update/remove old code and improve overall functionality.

Many of the new releases include popular libraries used by projects other than MirageOS, and the maintainers have helpfully provided details on what has changed, specific improvements and adjustments users will need to make in order to use them. These libraries include [Cohttp](https://github.com/mirage/ocaml-cohttp), [Conduit](https://github.com/mirage/ocaml-conduit), [DNS](https://github.com/mirage/ocaml-dns) and [TCP/IP](https://github.com/mirage/mirage-tcpip).

Main repackaging improvements to these libraries include:

* Optional dependencies removed from opam packaging: No need to specify a long set of packages to activate a specific compilation of features
* Ported to use [Jbuilder](https://github.com/janestreet/jbuilder): This speeds up builds and makes use of modern OCaml features
* No more camlp4! Camlp4 has been removed entirely, and the replacement [ppx_driver](https://github.com/janestreet/ppx_driver) makes use of [ocaml migrate parsetree](http://ocamllabs.io/projects/2017/02/15/ocaml-migrate-parsetree.html)

Get involved:

- Read the [release notes](https://discuss.ocaml.org/t/ann-major-releases-of-cohttp-conduit-dns-tcpip/571) for a full list of changes and incompatibilities
- Update your own code in line with these versions to avoid constraining users
- Join the conversation on the [OCaml Discuss Forum](https://discuss.ocaml.org/t/ann-major-releases-of-cohttp-conduit-dns-tcpip/571/2)

----
