---
uid: timada
date: 2017-01-16
enddate: 2017-01-22
week: 4
generator: furore
---

- Network performance evaluation
  - Conducted a test on the unix configuration, and found that the sender and receiver sides behavior was quite simple without any blocking periods. This indicates Xen or the network bridging on the hostOS can affect the blocking periods.
  - Having additional tests where the sender(receiver) program on a MV and the receiver(sender) program on Dom0 to reduce noise from the virtualization side.  
  - Had a meeting with Docker members to explain the findings. Comments from them are as follows;
    - To try to put one of the sender or receiver sides on Linux.
    - To try to have one unikernel VM having both the sender and receiver side using the vnetif module to completely remove noise from network bridging on the hostOS.
    - Checksum offloading and IP fragmentation offload will help us to improve the network performance.
    - ukvm rather than Xen would be better and easier for implementing a new network interface layer.

