---
authors: [lpw25]
title: "Type-based Record Disambiguation"
layout: page
---

[Leo White](http://www.lpw25.net/) helped with the record-disambiguation branch of OCaml by Jacques Garrigue. This branch uses type-information to disambiguate between record labels and variant constructors with the same names. For discussions of the semantics of this feature see [Gabriel's](http://gallium.inria.fr/~scherer/gagallium/resolving-field-names/) or [Alain's](http://www.lexifi.com/blog/type-based-selection-label-and-constructors) blog posts. Leo rewrote the record-disambiguation branch to use an alternative semantics and improved the error messages. The branch has since been [merged into OCaml trunk](https://github.com/ocaml/ocaml/commit/c8273a179cb0bc835924eeca522922a1769d9d54).

This feature was worked on between Sep 2012 - Feb 2013.

----

{% include news.html name="record-disambiguation" %}

----
