## == Bootable USB stick == ##
# https://help.ubuntu.com/community/Installation/FromUSBStick

## == Installing linux on the node using pxelinux == ##

sudo port install dnsmasq
sudo port install tftp-hpa

## == Configuring the dhcp server == ##
# http://www.debian-administration.org/articles/478/print
# sudo cp /opt/local/etc/dhcpd.conf.sample /opt/local/etc/dhcp.conf

# using dnsmasq on tomato firmware we can add the following
# dhcp-boot=pxelinux.0,epiclulz.local,192.168.1.10
# where epiclulz ist my macbook and .10 is it's ip address
# http://www.seephar.com/2008/09/pxe-boot-with-tomato/

sudo mkdir -p /opt/local/var/tftpboot/pxelinux.cfg

echo 'DISPLAY boot.txt

DEFAULT etch_i386_install

LABEL etch_i386_install
        kernel debian/etch/i386/linux
        append vga=normal initrd=debian/etch/i386/initrd.gz  --
LABEL etch_i386_linux
        kernel debian/etch/i386/linux
        append vga=normal initrd=debian/etch/i386/initrd.gz  --

LABEL etch_i386_expert
        kernel debian/etch/i386/linux
        append priority=low vga=normal initrd=debian/etch/i386/initrd.gz  --

LABEL etch_i386_rescue
        kernel debian/etch/i386/linux
        append vga=normal initrd=debian/etch/i386/initrd.gz  rescue/enable=true --

PROMPT 1
TIMEOUT 0' > /opt/local/var/tftpboot/pxelinux.cfg/default

echo '- Boot Menu -
=============

etch_i386_install
etch_i386_linux
etch_i386_expert
etch_i386_rescue' > /opt/local/var/tftpboot/pxelinux.cfg/boot.txt

cd /opt/local/var/tftpboot/pxelinux.cfg/
wget http://ftp.uk.debian.org/debian/dists/etch/main/installer-i386/current/images/netboot/debian-installer/i386/pxelinux.0
mkdir -p /opt/local/var/tftpboot/debian/etch/i386
cd /opt/local/var/tftpboot/debian/etch/i386
wget http://ftp.uk.debian.org/debian/dists/etch/main/installer-i386/current/images/netboot/debian-installer/i386/linux
wget http://ftp.uk.debian.org/debian/dists/etch/main/installer-i386/current/images/netboot/debian-installer/i386/initrd.gz

sudo tftpd -L -s /opt/local/var/tftpboot

# == For Ubuntu == #
# http://www.debuntu.org/how-to-unattended-ubuntu-network-install-preseed-p5
# http://www.debian.org/releases/stable/i386/apbs04.html.en
# sudo tftpd -L -s /Volumes/Ubuntu-Server\ 8./install/netboot
# sudo wget http://archive.ubuntu.com/ubuntu/dists/hardy/main/installer-i386/current/images/netboot/netboot.tar.gz
sudo wget http://archive.ubuntu.com/ubuntu/dists/intrepid/main/installer-i386/current/images/netboot/netboot.tar.gz
sudo tar xvf netboot.tar.gz

## == Appendix  == ##

# dnsmasq
###########################################################
# A startup item has been generated that will aid in
# starting dnsmasq with launchd. It is disabled
# by default. Execute the following command to start it,
# and to cause it to launch at startup:
#
# sudo launchctl load -w /Library/LaunchDaemons/org.macports.dnsmasq.plist
###########################################################

# TFTPd
# ***** Setup Instructions *****
# NOTE: By default, tftp-hpa listens to the tftp port specified in /etc/services (port 69)
#       on all local addresses.
# To run tftpd manually for download only access, use this command:
#   sudo tftpd -L -s <tftp-root-dir>
# To run tftpd manually and support tftp uploads, add "-c" to the command:
#   sudo tftpd -L -c -s <tftp-root-dir>
# You may run tftpd at system boot using the startupitem if you installed tftp-hpa
# using the server variant.  To load the startupitem using launchctl:
#   sudo launchctl load -w /Library/LaunchDaemons/org.macports.tftpd.plist
# NOTE: When loading tftp-hpa using launchctl, make sure to place the files you want to serve
# in /opt/local/var/tftp-hpa/, because that is the location set in the StartupItem.
# *******************************
# If you wish to run tftpd in inetd mode, you may make an inetd compatible .plist
# file and replace the one installed by MacPorts in /Library/LaunchDaemons.  You
# may use /System/Library/LaunchDaemons/tftp.plist as a template.
