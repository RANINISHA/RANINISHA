<h1 align="center">  To create  VM  of   linux/ARM64    using qemu  on  linux/x86_64<h1>
 
 

<h2 align="center"> Task Description </h2>

<p align="center" > To create  VM  of   linux/ARM64 architecture   using qemu  on  base os of linux/x86_64 architecture</p>
 
------
 
 <h2 align="center"> Environment</h2>
   <details close="close"> 
    <summary><b> Click here</b> :point_left:</summary>

  <ul>
  <li>Host OS version: NAME="Ubuntu"</li>
  <li>VERSION="20.04.2 LTS (Focal Fossa)" </li>
  <li>ARchitecture:x86_64</li>
  <li>RAM : 8GB</li>
  <li> Disk available.. : 589 GB </li>
    </ul>
  </details>

 -----------
 
<h1 align="center"> STEPS FOLLOWED TO CREATE  VM</h1>
 
 <h2 align="center"> step1: install packages</h2>

 <p align="center">  sudo apt-get install qemu-utils qemu-efi-aarch64 qemu-system-arm  </p >
  
 
 
  <h2 align="center"> step2: add ssh key to the image</h2>

 <p align="center"> sudo modprobe nbd /n
sudo qemu-nbd -c /dev/nbd0 debian-9.9.0-openstack-arm64.qcow2/n
sudo mount /dev/nbd0p2 /mnt /n
ssh-add -L > /mnt/home/debian/.ssh/authorized_keys/n
sudo umount /mnt/n
sudo qemu-nbd -d /dev/nbd0
 </p >
  
 
 
  <h2 align="center"> step1: install packages</h2>

 <p align="center">  sudo apt-get install qemu-utils qemu-efi-aarch64 qemu-system-arm  </p >
  
 
 
  <h2 align="center"> step1: install packages</h2>

 <p align="center">  sudo apt-get install qemu-utils qemu-efi-aarch64 qemu-system-arm  </p >
  
 
 
 
  <h2 align="center"> step1: install packages</h2>

 <p align="center">  sudo apt-get install qemu-utils qemu-efi-aarch64 qemu-system-arm  </p >
  
 
 
 
 ------- 
   
  
  




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

