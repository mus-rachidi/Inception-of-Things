#!/bin/bash
YELLOW='\033[0;33m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
ENDCOLOR='\033[0m'



sudo sed -i 's/PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config
sudo systemctl restart ssh
export INSTALL_K3S_EXEC="server --write-kubeconfig-mode 644  --advertise-address=192.168.58.140 --node-ip=192.168.58.140"
curl -sfL https://get.k3s.io |  sh -
cp /var/lib/rancher/k3s/server/node-token /vagrant/scripts/confs/
echo "alias k='k3s kubectl'" >> /etc/profile.d/apps-bin-path.sh
kubectl apply -f /vagrant/p2/confs/app1-deployment.yaml
kubectl apply -f /vagrant/p2/confs/app1-service.yaml
kubectl apply -f /vagrant/p2/confs/app2-deployment.yaml
kubectl apply -f /vagrant/p2/confs/app2-service.yaml
kubectl apply -f /vagrant/p2/confs/app3-deployment.yaml
kubectl apply -f /vagrant/p2/confs/app3-service.yaml
kubectl apply -f /vagrant/p2/confs/ingress.yaml