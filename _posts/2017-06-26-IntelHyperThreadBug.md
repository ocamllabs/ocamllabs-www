---
title: Intel hyper-threading bug uncovered by OCaml Developers
layout: post
author: gemmag
category: General
tags: intel ocaml debian compiler hyper-threading
---

The OCaml community has helped uncover a serious microcode defect on Intel Skylake and Kaby Lake processors with hyper-threading enabled. Debian have issued a [security advisory](https://lists.debian.org/debian-devel/2017/06/msg00308.html) encouraging users of systems with the affected processors to apply the BIOS/UEFI update, or disable hyper-threading.

Related issues have been under investigation since 2016, when OCaml developers began experiencing unpredictable behaviour when using the Intel Skylake and Kaby Lake CPUs. As detailed on the [Mantis issue](https://caml.inria.fr/mantis/view.php?id=7452), these included "random crashes from the compiler, and more rarely, occurrences of bad assembly code being generated (which as failed to compile), or instruction being trapped at runtime while the compiler is running." The issues were linked to hyper-threading, and mentioned to Intel back in March 2017, with no reply from them directly. Further investigation followed over the next few months, with developers continuing to reproduce the bug successfully, until a possible fix for the microcode defect was [noticed](http://metadata.ftp-master.debian.org/changelogs/non-free/i/intel-microcode/intel-microcode_3.20170511.1_changelog). The fix solved the OCaml issue, and it was quickly passed onto the Debian developers.

Thanks to Mark Shinwell for liaising with Intel and the Debian developers to help surface this issue.

Follow the conversation on the [Debian mailing list](https://lists.debian.org/debian-devel/2017/06/msg00308.html) and [Hacker News](https://news.ycombinator.com/item?id=14630183).
