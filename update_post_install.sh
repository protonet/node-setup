#!/bin/sh

HOST=protodeploy@deploy.flyingseagull.de

tar cjvf post_install.tar.bz2 post_install
scp post-install $HOST:deploy/assets
scp post_install.tar.bz2 $HOST:deploy/assets

rm post_install.tar.bz2
