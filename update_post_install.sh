#!/bin/sh

cd /opt/local/var/tftpboot/install/deploy_root/
# for os x tells tar not to include resource forks
export COPYFILE_DISABLE=true
tar cjvf post_install.tar.bz2 post_install
