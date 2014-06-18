#!/bin/bash

echo "Installing required software"
sudo apt-get install -y sysv-rc-conf

cp src/daemon-template.sh /etc/init.d/plumgrid
cp src/daemon-template.sh /etc/init.d/plumgrid-sal
cp src/daemon-template.sh /etc/init.d/nginx

sysv-rc-conf plumgrid on
sysv-rc-conf plumgrid-sal on
sysv-rc-conf nginx on

gcc -o daemon daemon.c
cp daemon /bin/plumgrid
cp daemon /bin/plumgrid-sal
cp daemon /bin/nginx

