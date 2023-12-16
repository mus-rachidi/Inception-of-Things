#!/bin/bash
K3S_TOKEN=$(cat /var/lib/rancher/k3s/server/node-token)
export INSTALL_K3S_EXEC="agent --server https://localhost:6443 --token $K3S_TOKEN --node-ip=192.168.59.145"
curl -sfL https://get.k3s.io | sh -
