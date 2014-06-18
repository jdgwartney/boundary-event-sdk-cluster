#!/usr/bin/env bash

echo "Installing required software"
sudo apt-get install -y git sysv-rc-conf

#echo "Install maven"
#sudo apt-get install -y maven2

#echo "Clone Boundary Event SDK"
#git clone https://github.com/boundary/boundary-event-sdk.git
#chown -R vagrant:vagrant boundary-event-sdk

source /vagrant/src/install_daemons.sh
