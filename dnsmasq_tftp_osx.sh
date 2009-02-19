#!/bin/sh

# set ethernet to 192.168.2.1 in sharing preferences
DNSMASQCONF=/opt/local/etc/dnsmasq.conf

sudo port install dnsmasq

sudo cp /opt/local/etc/dnsmasq.conf.sample $DNSMASQCONF
sudo perl -i -pe 's/^#dhcp-range=192.168.0.50,192.168.0.150,255.255.255.0,12h/dhcp-range=192.168.2.50,192.168.2.150,255.255.255.0,12h/' $DNSMASQCONF
sudo perl -i -pe 's/^#dhcp-boot=pxelinux.0/dhcp-boot=pxelinux.0/' $DNSMASQCONF
sudo perl -i -pe 's/^#enable-tftp/enable-tftp/' $DNSMASQCONF
sudo perl -i -pe 's/^#tftp-root=\/var\/ftpd/tftp-root=\/opt\/local\/var\/tftpboot/' $DNSMASQCONF
sudo -e echo '127.0.0.1 archive.ubuntu.com' >> /etc/hosts
# sudo mkdir -p /opt/local/var/tftpboot
# sudo cp -r netboot/ /opt/local/var/tftpboot
sudo cp -r netboot/* /opt/local/var/tftpboot
if [ ! -e /opt/local/var/db ]; then
  sudo mkdir /opt/local/var/db;
fi;
sudo /opt/local/sbin/dnsmasq -d
