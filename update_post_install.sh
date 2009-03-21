#!/bin/bash

# the archive of the post-install scripts
POST_ARCH=post_install.tar.bz2
POST_SERV="http://protodeploy/$POST_ARCH"
POST_DIR=post_install

cd /opt/local/var/tftpboot/install/deploy_root/
# for os x tells tar not to include resource forks
export COPYFILE_DISABLE=true
tar cjvf iptables.tar.bz2 post_install

# TODO: sign the releases so we can make sure ppl don't put malicious code
# in our deployment scripts

rm post-install
shopt -s extglob
for post_install in $POST_DIR/+(S[0-9][0-9]*[^~]) ; do
  cat $post_install >> post-install
done


# remove the temporary files
# rm -rf $POST_DIR
