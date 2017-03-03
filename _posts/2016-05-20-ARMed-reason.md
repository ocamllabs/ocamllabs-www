---
title: ARM-ed with Reason
layout: post
author: kc
category: Projects
tags: docker embedded reason 
---

I've been enjoying working with [Reason](http://facebook.github.io/reason/), and looking at ways to combine ARM, Reason
and Docker. Check out this [tutorial](http://kcsrk.info/reason/arm/2016/05/16/armed-with-reason/)
on how to build Reason apps for an ARM target using the Docker for Mac
beta program. Reason is packaged as a Docker image, so local installation is unnecessary, and Docker's multiarch support means no need for cross-compilation - what a breeze!

I am using [Docker for Mac](https://blog.docker.com/2016/03/docker-for-mac-windows-beta/), which is still under beta program. Using Docker for development has two important advantages over traditional cross-compilation. First, the Reason toolchain comes packaged as a Docker image and hence no local installation is necessary. Secondly, cross-compiler are often tricky to get right. Docker for Mac comes with multiarch support and hence removes the need for traditional cross-compilation.

### Setup

I will be testing using a [Cubietruck](https://en.wikipedia.org/wiki/Cubieboard) running Linaro
Desktop. But these instructions should also work for [Raspbian](https://www.raspbian.org/), a Debian optimized for the
Raspberry pi hardware.

### Build

First get the dockerfile for Reason toolchain and build the image.

`$ mkdir /tmp/reason_arm`  
`$ cd /tmp/reason_arm`  
`$ wget `[`https://gist.githubusercontent.com/kayceesrk/dc37a6ffeeda2dea338550dd4e8ad7ec/raw/8e136b8b8170758bd5e9c0cacf70fed4f9ce3df1/Dockerfile`](https://gist.githubusercontent.com/kayceesrk/dc37a6ffeeda2dea338550dd4e8ad7ec/raw/8e136b8b8170758bd5e9c0cacf70fed4f9ce3df1/Dockerfile)  
`$ docker build -t reason-arm .`

All set! Let's build a "Hello, World!" program.

`$ mkdir /tmp/reason_arm_hello`  
`$ cd /tmp/reason_arm_hello`  
`$ echo 'print_endline "Hello, Reason!"' > hello.re`  
`` $ docker run -it -v `pwd`:/src reason-arm ``  
`$ cd /src`  
`$ rebuild hello.native`  
`^C`

The build artifacts are found in the host machines
`/tmp/reason_arm_hello/_build` directory.

`$ file _build/hello.native`  
`_build/hello.native: ELF 32-bit LSB executable, ARM, version 1 (SYSV), dynamically linked (uses shared libs), for GNU/Linux 2.6.32, not stripped`

We can now transfer the file to the cubietruck and run it. My
cubietruck's IP address is `192.168.0.9`.

`$ scp _build/hello.native linaro@192.168.0.9:`  
`$ ssh linaro@192.168.0.9`  
`Welcome to Linaro 13.04 (GNU/Linux 3.4.61+ armv7l)`  
`* Documentation:  `[`https://wiki.linaro.org/`](https://wiki.linaro.org/)  
`Last login: Fri May 20 08:35:01 2016 from 192.168.0.3`  
`linaro@cubietruck:~$ ./hello.native`  
`Hello, reason!`
