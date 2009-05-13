echo '#!/bin/sh

PATH=/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

edge -f -d n2n0 -c mynetwork -k encryptme -a 10.0.0.2 -l flyingseagull.de:1099' > /etc/init.d/n2n

chmod +x /etc/init.d/n2n
# add the startup script to the autostart
update-rc.d n2n defaults
