#!/bin/bash

export INSTALL_K3S_EXEC="agent  --server https://192.168.59.140:6443 --token-file /vagrant/confs/token --node-ip=192.168.59.141"
curl -sfL https://get.k3s.io |  sh -
echo "alias k='k3s kubectl'" >> /etc/profile.d/apps-bin-path.sh