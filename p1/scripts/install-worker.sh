#!/bin/bash
YELLOW='\033[0;33m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
ENDCOLOR='\033[0m'



export INSTALL_K3S_EXEC="agent --server https://192.168.59.140:6443 --token-file /vagrant/node-token --node-ip=192.168.59.141"
curl -sfL https://get.k3s.io |  sh -