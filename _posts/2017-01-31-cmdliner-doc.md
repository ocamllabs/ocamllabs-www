---
title: Feedback on cmdliner doc language changes
layout: post
author: dbuenzli
category: RFC
tags: cmdliner documentation platform libraries
---

The next release of cmdliner aims to improve the current cmdliner manual doc language. Your feedback on the changes and new language definition is welcome:

* [changes](https://github.com/dbuenzli/cmdliner/blob/08be600c4b7f00c08339f078a88b30234d84fc44/CHANGES.md#doc-language-sanitization)
* [source](https://github.com/dbuenzli/cmdliner/blob/master/src/cmdliner.mli#L755-L768)
* discussion on the issue [here](https://github.com/dbuenzli/cmdliner/issues/68)

**Take note:** The fix may break the rendering of some manpages:

If `git grep '\$([ib],[^)]*\$([mt]name)[^)]*)'` exits with 0 in your project you are affected. Simply replace these marked up `$(b,$(tname))` and `$(b,$(mname))` by the variables `$(tname)` and `$(mname)` themselves.
