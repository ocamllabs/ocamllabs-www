---
authors: [hannesm, avsm, engil]
title: "Canopy: A git-blogging unikernel"
layout: page
---

[Canopy](https://github.com/Engil/Canopy) is a git-blogging unikernel. It was built with simplicity in mind, and provides a simple blog platform that only requires a Git URL. It is written in OCaml, uses MirageOS and Irmin, has HTTPS and TLS support, and runs on Unix and Xen.

Canopy will require you to provide a Git remote URL. Once started, it will clone in-memory the repository content and serve the content in a more or less organized way. Each file at the root of the repository is considered a standalone page, (e.g. « About » or « Contact » pages), and they will have their own entries in the navigation menu. The file syntax is markdown, everything should be supported out-the-box.

While in Marrakech, Enguerrand wrote a simple blog unikernel, Canopy which relies on Irmin's capabilities to synchronise remote git repositiories. By describing new pages in a format similar to Jekyll (and using Markdown) on a git repository, new content pushed there would be pulled to the website and displayed there nicely. This allowed every participant to report on their current projects, and see the content displayed on the notepad after a simple git push.

----

{% include news.html name="canopy" %}

----
