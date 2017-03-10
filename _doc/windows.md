---
authors: [gemmag, avsm, dra27, altgr]
title: "Windows Support"
layout: page
---

With OCaml support for Windows lacking in the past, there's a concerted effort underway to improve using OCaml on Windows, and for ongoing continuous integration and testing.

[David Allsopp](https://github.com/dra27) has been working on steadily improving Windows support for ~10 years, and this has involved extensive work within both the OCaml and Windows communities. 

* Opam-on-Windows  
Progress on an Opam Windows port is ongoing, with the eventual goal of Cygwin integration.

* Windows CI
  - Visual Studio Test Matrix
  - Windows Versions Test Matrix  

----

## Compiling on Native Windows

**NOTE: Building on Windows is a WIP, with instructions likely to evolve**

### Cygwin

Cygwin is required to build opam on windows, with correct compilation requiring both a 64-bit and 32-bit C compiler in order to build `opam-putenv`. Opam on Windows requires OCaml 4.02 or later.

See the [repository](https://github.com/dra27/opam/tree/windows) for further details on which [Cygwin packages](https://github.com/dra27/opam/tree/windows#compiling-on-native-windows) are required and which Cygwin commands are required by opam.

### Git for Windows

Git-for-Windows is available for  [download](https://git-scm.com/download/win), with the default selection of components sufficient for opam.


----

{% include news.html name="windows" %}
