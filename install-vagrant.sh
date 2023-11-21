#!/bin/bash

# Script to install Vagrant on Ubuntu

echo "Installing Vagrant..."

# Add the HashiCorp GPG key
wget -qO- https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x6B05F25D762E3157 | sudo gpg --dearmor -o /usr/share/keyrings/vagrant-archive-keyring.gpg

# Add the Vagrant APT repository
echo 'deb [signed-by=/usr/share/keyrings/vagrant-archive-keyring.gpg] https://releases.hashicorp.com/vagrant focal main' | sudo tee /etc/apt/sources.list.d/vagrant.list

# Update and install Vagrant
sudo apt-get update
sudo apt-get install -y vagrant

echo "Vagrant installation complete."
