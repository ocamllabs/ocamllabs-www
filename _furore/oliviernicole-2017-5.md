---
uid: oliviernicole
date: 2017-01-23
week: 5
generator: furore
---

* Fixed small bugs with lambda quoting, bootstrapped the compiler.
* Added some (hopefully temporary) code to print lambda quotes in the REPL.
* Fixed a bug on `macros_unstable` that caused the compiler to crash when
  encountering a structure item with more than one splice in it.
* On the way of fixing the bug that makes codes like:
  ```
  module M = struct
    $ << () >>
  end
  ```
  segfault.

