---
authors: [avsm]
title: "OCaml and OPAM Docker Container Images"
layout: page
---

[Docker](http://docker.com) is a container manager that can build images automatically by reading the instructions from a `Dockerfile`. A Dockerfile is a text document that contains all the commands you would normally execute manually in order to build a Docker image. By calling `docker build` from your terminal, you can have Docker build your image step-by-step, executing the instructions successively. We maintain OCaml and OPAM images across a variety of Linux distributions, which can be used for [continuous integration testing]({% link _doc/ci.md %}) or for day-to-day code development using [Docker for Mac or Windows](https://www.docker.com/products/docker).

### TL;DR for OPAM use

- Base image for Debian available via `ocaml/opam`.  Use it in a Dockerfile via `FROM ocaml/opam` or directly via `docker run -it ocaml/opam` to get an interactive shell with OPAM initialised.
- The images all contain an `opam` user with the default remote as `/home/opam/opam-repository`.  You can merge extra commits in there and run `opam update` (e.g. to test PRs).
- See this [travis.yml](https://github.com/avsm/ocaml-dockerfile/blob/master/.travis.yml) for an example of how to do multi-distro testing using the [Travis CI service](http://travis-ci.org).
- Look at [opam install docker-infra](https://github.com/avsm/ocaml-docker-infra) for CLI commands that generate Dockerfiles for your projects.

## Building a development image

* The [ocaml-dockerfile](https://github.com/avsm/ocaml-dockerfile) repository has a DSL to generate your own Dockerfiles programmatically.
* The [ocaml-docker-infra](https://github.com/avsm/ocaml-docker-infra) repository has CLI commands that generate Dockerfiles for your projects for common tasks such as building PRs from GitHub.

## Base Images

There are several sets of layered images published on the Docker Hub:

* [ocaml/ocaml](https://hub.docker.com/r/ocaml/ocaml/):  The base OCaml images install the development tools and a system OCaml compiler that is sufficient to build OPAM.  These are not intended to be used directly by users since the exact version of the OCaml compiler depends on the distribution involved.
* [ocaml/opam](https://hub.docker.com/r/ocaml/opam/): The base OPAM images that provide an initialised OPAM environment with a specific version of the OCaml compiler, and a working `opam depext` plugin.
* [ocaml/opam-dev](https://hub.docker.com/r/ocaml/opam-dev/): The base OPAM2 images that provide an initialised OPAM2 environment with a specific version of the OCaml compiler, and a working `opam depext` plugin.  These use the latest snapshots of the OPAM2 development branch, with a migrated OPAM repository.

Most users should primarily use the `ocaml/opam` endpoint for development. These images all have multiple Docker tags associated with them, each of which represents a combination of the distribution and OCaml version.  For example, `docker pull ocaml/opam:alpine-3.5_ocaml-4.04.0` will obtain the Alpine Linux 3.5 and OCaml 4.04.0 image.

When building Dockerfiles from this image, the [entrypoint](https://docs.docker.com/engine/reference/builder/#entrypoint) to the container runs the command via `opam config exec --`, which ensures that all of the locally installed OPAM libraries and environment variables are set.

See the Docker Hub [README](https://hub.docker.com/r/ocaml/opam/) for the full list of supported distributions and compiler snapshots.

### Using these images

The Hub images are rebuilt weekly from the latest public [OPAM repository](https://github.com/ocaml/opam-repository). You can therefore use them as the basis for automated testing and local development.

#### Automated testing

Many continuous integration systems now support Docker containers, and so you can use them to test your software on several distributions.

##### Travis CI

The [ocaml/ocaml-ci-scripts](https://github.com/ocaml/ocaml-ci-scripts) contains shell scripts and documentation about how to activate Travis builds.

Inside there is support for multi-distro builds as well; see this example in [OCaml-Dockerfile](https://github.com/avsm/ocaml-dockerfile/blob/master/.travis.yml) for an example of how to use it in Travis to build the same package on Debian, Ubuntu, CentOS, Fedora, Alpine and other Linux variants.

##### Local CI

If you install Docker on your laptop, you can also run the _same_ tests offline as well as via online CI.  This is useful to test things quickly before pushing them to GitHub.

##### On-prem CI

If you want to run the containers on your own servers, then some additional services can be brought up to provide the support:

- *[ocaml/opam-archive](https://hub.docker.com/r/ocaml/opam-archive)* provides a web service running on port 8081 that serves the latest snapshot of the OPAM repository (including all the source code).
- *[avsm/opam-solver-proxy](https://hub.docker.com/r/avsm/opam-solver-proxy)* provides a remote Aspcud solver service.  This is necessary for those distributions that do not natively package Aspcud.

Both of these can be run inside a [Docker Compose](https://docs.docker.com/compose/) file, or via the [Docker Cloud](http://cloud.docker.com) service.  For example, a public version of the solver runs at <http://solver.ocaml.io:8080>, and is used by default in distributions that do not include Aspcud (such as Fedora 24 or CentOS 7).

### Contributing new base images

* See various distros in README. TODO
* Built by calling dockerfile-ocaml and pushing to ocaml/ocaml-dockerfiles and an autobuild on Docker Hub.

New images are most welcome.

Steps:

* opam depext must work with the distro
* add ocaml-dockerfile support for the new one
