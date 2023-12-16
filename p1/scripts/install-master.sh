#!/bin/bash

export INSTALL_K3S_EXEC="server --write-kubeconfig-mode 644  --advertise-address=192.168.59.140 --node-ip=192.168.59.140"
curl -sfL https://get.k3s.io |  sh -
cp /var/lib/rancher/k3s/server/node-token /vagrant/confs/
echo "alias k='k3s kubectl'" >> /etc/profile.d/apps-bin-path.sh
