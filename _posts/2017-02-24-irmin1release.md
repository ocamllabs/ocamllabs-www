---
title: Irmin 1.0 Released!
layout: post
author: gemmag
category: Projects
tags: irmin mirage opam libraries
---

[Irmin 1.0](https://github.com/mirage/irmin) is now released and available on [opam](https://opam.ocaml.org/packages/irmin/irmin.1.0.0/). You can see a full set of [changes](https://github.com/mirage/irmin/releases/tag/1.0.0), online [documentation](https://mirage.github.io/irmin/Irmin.html) and some [examples](https://github.com/mirage/irmin/tree/master/examples) to help get you started.

## Background

[Irmin](https://github.com/mirage/irmin) is a library for persistent data stores with version-control following similar principles as Git. Irmin is written in pure OCaml (it does not depend on external C stubs) and runs on a variety of [backends](https://github.com/mirage/irmin/tree/1.0.0#backends).

Work on Irmin started back in 2013 with partial funding from [UCN](https://usercentricnetworking.eu/), and early data structures were detailed in a [JFLA paper](http://anil.recoil.org/papers/2015-jfla-irmin.pdf) in 2015. The original idea behind Irmin was to be able to apply the features of a distributed version-control system (DVCS) to big data. By using existing tools around source-code version control they were able to apply the same functionality as a library, therefore providing significant flexibility and efficiency at a reasonable cost.

[Thomas Gazagnaire](http://gazagnaire.org/) has matured the project extensively over the last 4 years, and this release seeks to build on feedback gathered from early users by delivering an [API](https://mirage.github.io/irmin/) that is easier to use and more efficient than ever before.

[Datakit](https://github.com/docker/datakit) from [Docker](https://www.docker.com) utilises Irmin, and forms a component of the [Docker for Mac and Windows](http://ocamllabs.io/releases/2016/05/18/datakit.html) application.

## Further Reading

Irmin [use-cases](https://github.com/mirage/irmin#use-cases) are detailed in the GitHub repository.

* [The functional innards of Docker for Mac and Windows](http://ocamllabs.io/talks/#talks-ldnfunc16anil)
* [CueKeeper: Getting things done in the browswer](http://roscidus.com/blog/blog/2015/04/28/cuekeeper-gitting-things-done-in-the-browser/) - CueKeeper is a TODO list that uses Irmin to manage history, reversion and synchronisation.
* [What a distributed, version-controlled ARP cache gets you](https://www.somerandomidiot.com/blog/2015/04/24/what-a-distributed-version-controlled-ARP-cache-gets-you/)
* [Persistent networking with Irmin and MirageOS](http://decks.openmirage.org/ocaml15-irminnet#/)
* [Using Irmin to add fault-tolerance to the Xenstore database](https://mirage.io/blog/introducing-irmin-in-xenstore)
* [Introducing Irmin: Git-like distributed, branchable storage](https://mirage.io/blog/introducing-irmin)
* [Mergeable persistent data structures](http://anil.recoil.org/papers/2015-jfla-irmin.pdf)

Development of Irmin was supported in part by the EU FP7 User-Centric Networking project, Grant No. 611001.
