#!/bin/bash
# install vagrant on ubuntu 

echo "Installing Vagrant..."

wget -qO- https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x6B05F25D762E3157 | sudo gpg --dearmor -o /usr/share/keyrings/vagrant-archive-keyring.gpg

echo 'deb [signed-by=/usr/share/keyrings/vagrant-archive-keyring.gpg] https://releases.hashicorp.com/vagrant focal main' | sudo tee /etc/apt/sources.list.d/vagrant.list

sudo apt-get update
sudo apt-get install -y vagrant

echo "Vagrant installation complete."
