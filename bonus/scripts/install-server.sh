#!/bin/bash
YELLOW='\033[0;33m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
ENDCOLOR='\033[0m'

export INSTALL_K3S_EXEC="server --write-kubeconfig-mode 644  --advertise-address=192.168.60.110 --node-ip=192.168.60.110"
curl -sfL https://get.k3s.io |  sh -
echo "alias k='k3s kubectl'" >> /etc/profile.d/apps-bin-path.sh