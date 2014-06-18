#!/bin/bash

PROVISION_DIR=/vagrant

source $PROVISION_DIR/src/scripts/utils.sh

addUser boundary boundary boundary

echo "Installing required software"
sudo apt-get install -y sysv-rc-conf

replaceDaemon() {
  typeset -r name=$1
  typeset -r port=$2
  sed -e"s/@@DAEMON@@/$name/g" | sed -e"s/@@PORT@@/$port/g" 
}

echo "Copy scripts to init.d"
cat $PROVISION_DIR/src/scripts/daemon-template.sh | replaceDaemon plumgrid 10010 > /etc/init.d/plumgrid
chmod 774 /etc/init.d/plumgrid
cat $PROVISION_DIR/src/scripts/daemon-template.sh | replaceDaemon plumgrid-sal 10011 > /etc/init.d/plumgrid-sal
chmod 774 /etc/init.d/plumgrid-sal
cat $PROVISION_DIR/src/scripts/daemon-template.sh | replaceDaemon nginx 10012 > /etc/init.d/nginx
chmod 774 /etc/init.d/nginx

echo "Register daemons to autostart"
sudo sysv-rc-conf plumgrid on
sudo sysv-rc-conf plumgrid-sal on
sudo sysv-rc-conf nginx on

echo "Build and installed daemons"
gcc -o daemon $PROVISION_DIR/src/daemon.c
cp daemon /bin/plumgrid
chmod 744 /bin/plumgrid
cp daemon /bin/plumgrid-sal
chmod 744 /bin/plumgrid-sal
cp daemon /bin/nginx
chmod 744 /bin/nginx
rm daemon

echo "Start the daemon"
service plumgrid start
service plumgrid-sal start
service nginx start

echo 'PATH=/vagrant/bin:$PATH' >> /home/vagrant/.bashrc


