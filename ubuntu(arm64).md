
















I  have to create  VM  of   linux/ARM64    using qemu   on below  environment  :

Host OS version: NAME="Ubuntu"
VERSION="20.04.2 LTS (Focal Fossa)"
ARchitecture:x86_64
RAM : 8GB
Disk available.. : 589 GB 

for which i have used the link below:

https://wiki.debian.org/Arm64Qemu

In 2nd step of above link  ,while executing  below command:

$ sudo qemu-nbd  -vc /dev/nbd0 debian-9-openstack-arm64.qcow2
I  got the error:
qemu-nbd: Failed to set NBD socket

[SOLUTION]

To resolve the issue i performed below steps:

1) sudo modprobe nbd     // to load the module nbd
2) sudo lsmod |grep nbd    //to check whether kermel module nbd is loaded
if it is loaded   it will show output  like this :
nbd                    45056  3
3) I tried 

 by specifying qcow2 format =>
$ sudo qemu-nbd  -c /dev/nbd0  -f qcow2 debian-9-openstack-arm64.qcow2  and it worked without any error

Hence the  NBD socket  issue is resolved.

