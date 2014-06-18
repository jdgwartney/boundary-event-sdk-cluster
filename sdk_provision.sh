#!/usr/bin/env bash

echo "Installing required software"
sudo apt-get install -y git sysv-rc-conf

#echo "Install maven"
#sudo apt-get install -y maven2

#echo "Clone Boundary Event SDK"
#git clone https://github.com/boundary/boundary-event-sdk.git
#chown -R vagrant:vagrant boundary-event-sdk
#cd boundard-event-sdk
#cp src/test/scripts/daemon.sh /bin/plumgrid
cp src/test/scripts/daemon-template.sh /etc/init.d/plumgrid

gcc -o plumgrid daemon.c
cp plumgrid /bin/plumgrid
sysv-rc-conf plumgrid on

