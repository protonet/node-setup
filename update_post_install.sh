#!/bin/sh

HOST=protodeploy@deploy.flyingseagull.de

# for os x tells tar not to include resource forks
export COPYFILE_DISABLE=true
tar cjvf post_install.tar.bz2 post_install
scp post-install $HOST:deploy/assets
scp post_install.tar.bz2 $HOST:deploy/assets
scp netboot/install/preseed/preseed.cfg $HOST:deploy/assets

rm post_install.tar.bz2
