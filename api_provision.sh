#!/bin/bash

echo "Installing required software"
sudo apt-get install -y sysv-rc-conf

source /vagrant/src/install_daemons.sh
