---
uid: timada
date: 2017-01-02
enddate: 2017-01-08
week: 2
generator: furore
---

- Network performance evaluation
  - finished preparing for performance bottleneck investigation.
    - finished learning and testing how to conduct tracing on Xen as well as on QEMU/KVM.
    - finished building my MirageOS environment with the profiling support.
  - TCP-based iperf tracing
    - Found the vCPU utilization on the receiver side reached 100% though the sender side did not (~30%)
    - also found it difficult to capture their behavior due to complicated ACK/SYN mechanisms in the TCP stack, so decided to use UDP.
    - I will resume this after finishing the UDP-based iperf investigation
  - UDP-based iperf tracing
    - Finished coding UDP-based iperf based on TCP-based iperf
    - Tracing in the MirageOS layer and the Xen layer by using the mirage-trace-viewer, xentop and xentrace commandes

