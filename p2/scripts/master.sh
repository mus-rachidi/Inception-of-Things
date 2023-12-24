#!/bin/bash

export INSTALL_K3S_EXEC="server --write-kubeconfig-mode 644  --advertise-address=${MASTER_IP} --node-ip=${MASTER_IP}"
curl -sfL https://get.k3s.io |  sh -
cp /var/lib/rancher/k3s/server/node-token /vagrant/confs/
echo "alias k='k3s kubectl'" >> /etc/profile.d/apps-bin-path.sh


kubectl apply -f /vagrant/confs/AppOne/app1-deployment.yaml
kubectl apply -f /vagrant/confs/AppOne/app1-service.yaml
kubectl apply -f /vagrant/confs/AppOne/app1-ingress.yaml

kubectl apply -f /vagrant/confs/AppTwo/app2-deployment.yaml
kubectl apply -f /vagrant/confs/AppTwo/app2-service.yaml
kubectl apply -f /vagrant/confs/AppTwo/app2-ingress.yaml

kubectl apply -f /vagrant/confs/Appthree/app3-deployment.yaml
kubectl apply -f /vagrant/confs/Appthree/app3-service.yaml
kubectl apply -f /vagrant/confs/Appthree/app3-ingress.yaml