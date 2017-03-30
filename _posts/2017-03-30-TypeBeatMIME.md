---
title: "Parsing the Email Standard with TypeBeat"
layout: post
author: gemmag
category: General
tags: email opensource parsing platform ocaml databox angstrom web typebeat topkg mrmime
---

`Content-Type` describes the type of content in the message body of an email or HTTP request, and is represented by a [MIME](https://tools.ietf.org/html/rfc2045) type, which indicates the type of data that file contains.

See [IANA](http://www.iana.org/assignments/media-types/media-types.xhtml) for an exhaustive list of media types.

Parsing the value of `Content-Type` is difficult, so [Romain Calascibetta](https://github.com/dinosaure) has created [TypeBeat](https://github.com/oklm-wsh/TypeBeat): a light library to compute the complex rules for you. TypeBeat uses [Angstrom](https://github.com/inhabitedtype/angstrom) to handle complex rules related to RFCs and centralises it into one library for ease of use.

{% twitter https://twitter.com/Dinoosaure/status/847230863817359364 %}

Related papers:

* [Mr Mime](http://din.osau.re/mrmime.pdf)

----
