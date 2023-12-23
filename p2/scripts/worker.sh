#!/bin/bash

export INSTALL_K3S_EXEC="agent  --server https://192.168.56.112:6443 --token-file /vagrant/confs/node-token --node-ip=192.168.56.113"
curl -sfL https://get.k3s.io |  sh -
echo "alias k='k3s kubectl'" >> /etc/profile.d/apps-bin-path.sh