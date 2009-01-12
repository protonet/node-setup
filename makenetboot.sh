#!/bin/bash

# wget http://archive.ubuntu.com/ubuntu/dists/hardy/main/installer-i386/current/images/netboot/netboot.tar.gz
# mkdir netboot
cd netboot
# tar xzvf ../netboot.tar.gz
# rm pxelinux.cfg
# rm pxelinux.0
# mkdir -p install/preseed
# cp ../preseed.cfg install/preseed/preseed.cfg
# mv ubuntu-installer/i386/linux install
# mv ubuntu-installer/i386/initrd.gz install
# mv ubuntu-installer/i386/pxelinux.0 .
# mv ubuntu-installer/i386/pxelinux.cfg .
# rm -rf ubuntu-installer
# cp ../default pxelinux.cfg/
# cp ../boot.txt .

tar cjvf ../netboot.tar.bz2 *

