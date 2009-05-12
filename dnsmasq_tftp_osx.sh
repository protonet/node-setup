#!/bin/bash
trap bashtrap INT

# bash clear screen command
clear;
# bash trap function is executed when CTRL-C is pressed:
# bash prints message => Executing bash trap subrutine !
bashtrap()
{
  echo "CTRL+C Detected !...executing bash trap !"
  sudo squid -k kill
  sudo killall lighttpd
}

# set ethernet to 192.168.2.1 in sharing preferences
DNSMASQCONF=/opt/local/etc/dnsmasq.conf

# sudo cp /opt/local/etc/dnsmasq.conf.sample $DNSMASQCONF
# sudo perl -i -pe 's/^#dhcp-range=192.168.0.50,192.168.0.150,255.255.255.0,12h/dhcp-range=192.168.2.50,192.168.2.150,255.255.255.0,12h/' $DNSMASQCONF
# sudo perl -i -pe 's/^#dhcp-boot=pxelinux.0/dhcp-boot=pxelinux.0/' $DNSMASQCONF
# sudo perl -i -pe 's/^#enable-tftp/enable-tftp/' $DNSMASQCONF
# sudo perl -i -pe 's/^#tftp-root=\/var\/ftpd/tftp-root=\/opt\/local\/var\/tftpboot/' $DNSMASQCONF
PATH=/opt/local/sbin:$PATH

if [ ! -x /opt/local/sbin/dnsmasq ]; then
  sudo port install dnsmasq
fi
if [ ! -x /opt/local/sbin/lighttpd ]; then
  sudo port install lighttpd
fi
if [ ! -x /opt/local/sbin/squid ]; then
  sudo port install squid
fi

# lighty stuff
sudo mkdir -p /opt/local/var/lighttpd/log
sudo cp conf/lighttpd.conf /opt/local/etc/lighttpd

sudo cp conf/dnsmasq.conf $DNSMASQCONF

sudo mkdir -p /opt/local/var/tftpboot
sudo cp -r netboot/* /opt/local/var/tftpboot

sudo bash update_post_install.sh

if [ ! -e /opt/local/var/db ]; then
  sudo mkdir /opt/local/var/db;
fi;

if [ ! -e /opt/local/var/squid/cache/00 ]; then
  sudo squid -z
fi;

sudo cp conf/squid.conf /opt/local/etc/squid/

sudo lighttpd -f /opt/local/etc/lighttpd/lighttpd.conf
sudo squid
sudo /opt/local/sbin/dnsmasq -d
