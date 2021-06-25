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

 <p align="center"> sudo modprobe nbd </p>
<p align="center"> sudo qemu-nbd  -c /dev/nbd0  -f qcow2 debian-9-openstack-arm64.qcow2 </p>
<p align="center"> sudo mount /dev/nbd0p2 /mnt </p>
<p align="center"> ssh-add -L > /mnt/home/debian/.ssh/authorized_keys </p>
<p align="center"> sudo umount /mnt </p>
<p align="center">sudo qemu-nbd -d /dev/nbd0 </p>
 
 -------
 
  <h2 align="center"> step3: boot the image</h2>

 <p align="center"> qemu-system-aarch64 -m 2G -M virt -cpu max \
  -bios /usr/share/qemu-efi-aarch64/QEMU_EFI.fd \
  -drive if=none,file=debian-9-openstack-arm64.qcow2,id=hd0 -device virtio-blk-device,drive=hd0 \
  -device e1000,netdev=net0 -netdev user,id=net0,hostfwd=tcp:127.0.0.1:5555-:22 \
  -nographic </p >
  
 ---------
 
  <h2 align="center"> step4: use ssh to login </h2>

 <p align="center">  ssh debian@127.0.0.1 -p 5555  </p >
 
 -----
  
    <h2 align="center"> Refference link </h2>
 
  <p align="center">  https://wiki.debian.org/Arm64Qemu </p >

 
 

 
  




