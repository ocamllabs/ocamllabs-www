---
authors: [avsm, hannesm]
title: "Not Quite So Broken Software"
layout: page
---

Protocol implementations have lots of security flaws. The immediate causes of these are often programming errors, e.g. in memory management, but the root causes are more fundamental: the challenges of interpreting the ambiguous prose specification (RFCs), the complexities inherent in large APIs and code bases, inherently unsafe programming choices, and the impossibility of directly testing conformance between implementations and the specification.

Not-quite-so-broken is the theme of our re-engineered approach to security protocol specification and implementation that addresses these root causes. The same code serves two roles: it is both a specification, executable as a test oracle to check conformance of traces from arbitrary implementations, and a usable implementation; a modular and declarative programming style provides clean separation between its components. Many security flaws are thus excluded by construction.

You can read more in the papers below, or at the main [nqsb.io](https://nqsb.io) homepage.

----

{% include news.html name="nqsb" %}
