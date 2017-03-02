---
authors: [avsm, samoht]
title: Continuous Integration for OCaml
layout: page
---

*This is a work in progress document, contact anil@recoil.org*

The OCaml project has a lot of physical infrastructure to host services and run automated continuous integration tests.  OCaml Labs maintains a bunch of these, mainly centred around the [DataKit CI](https://github.com/docker/datakit) continuous integration system released by Docker.  This page describes how the CI works, where it is deployed, and what the roadmap for next steps are.

## Background

The DataKit CI is a domain-specific language to describe continuous integration tests that should run on every commit to a repository.  The test descriptions define tests that take a precise set of Git inputs as their inputs, run functions across them, and report the results as GitHub [statuses](https://developer.github.com/v3/repos/statuses/).  If any changes are pushed to the source code repositories being tracked, the tests are rerun on the new code.  Results are stored in Git branches, so that they can be checked out individually and inspected to help diagnose where failures came from.

The details of DataKit CI are documented in the [repository](https://github.com/docker/datakit/tree/master/ci), and the rest of this page describes the OCaml, OPAM and MirageOS test pieces specifically, and their relevance to OCaml developers.

* Source code: <https://github.com/avsm/mirage-ci>

## Deployments

TODO

* <https://ci.ocaml.io>
* <https://ci.mirage.io>

## Development

### Maintainers Guide

#### OPAM Repository

TODO

* What tests are run
* What the UI does
* How to checkout the state code

### Next Steps

### Phase 1

TODO

----

{% include news.html name="ci" %}
