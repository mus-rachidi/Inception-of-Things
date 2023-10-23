#!/bin/bash

# install k3d and kubectl
sudo sed -i 's/PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config
sudo systemctl restart ssh
export INSTALL_K3S_EXEC="server --write-kubeconfig-mode 644  --advertise-address=192.168.59.140 --node-ip=192.168.59.140"
curl -sfL https://get.k3s.io |  sh - 
 
# install helm 
curl -sSL https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash

# add repo 
helm repo add gitlab https://charts.gitlab.io/
helm repo update



