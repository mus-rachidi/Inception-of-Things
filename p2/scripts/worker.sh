#!/bin/bash

export INSTALL_K3S_EXEC="agent  --server https://${MASTER_IP}:6443 --token-file /vagrant/confs/node-token --node-ip=${WORKER_IP}"
curl -sfL https://get.k3s.io |  sh -
echo "alias k='k3s kubectl'" >> /etc/profile.d/apps-bin-path.sh