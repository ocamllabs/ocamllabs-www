---
title: conduit 0.14.0 released
date: 2016-12-26 00:52
layout: post
tags: ["conduit","Releases"]
---

Network connection library for TCP and SSL


The `conduit` library takes care of establishing and listening for TCP and
SSL/TLS connections for the Lwt and Async libraries.

The reason this library exists is to provide a degree of abstraction
from the precise SSL library used, since there are a variety of ways to bind to
a library (e.g. the C FFI, or the Ctypes library), as well as well as which
library is used (either OpenSSL or a native OCaml TLS implementation).

If you are using the `Lwt_unix` version of the library, you can set two
environment variables to control the behaviour of the library:

- `CONDUIT_DEBUG=1` will output debug information to standard error.
- `CONDUIT_TLS=native` will force the use of the pure OCaml TLS library.
