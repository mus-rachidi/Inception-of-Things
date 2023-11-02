#!/bin/bash

GREEN="\e[32m"
ENDCOLOR="\e[0m"

echo -e "${GREEN} Create cluster , Creating...${ENDCOLOR}"
sudo apt-get update -y
sudo apt-get install apt-transport-https ca-certificates curl software-properties-common -y
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update -y
apt-cache policy docker-ce
sudo apt-get install --yes docker-ce
sudo usermod -aG docker ${USER}
wget -q -O - https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash
k3d cluster create argocd 
echo -e "${GREEN}====================================================${ENDCOLOR}"

echo -e "${GREEN} Create the namespace dev argocd gitlab, Creating...${ENDCOLOR}"
kubectl create namespace dev 
kubectl create namespace argocd 
kubectl create namespace gitlab 
echo -e "${GREEN}====================================================${ENDCOLOR}"

echo -e "${GREEN} apply argocd ...${ENDCOLOR}"
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/v2.3.5/manifests/install.yaml
echo -e "${GREEN}====================================================${ENDCOLOR}"

sleep 10
namespace="argocd"
while true; do
  running_pods=$(kubectl get pod -n $namespace | grep -c "Running")
  total_pods=$(kubectl get pod -n $namespace | grep -c "argocd-")

  if [ "$running_pods" -eq "$total_pods" ]; then
    sleep 10
    echo -e "${GREEN} Deploy application...${ENDCOLOR}"
    kubectl apply -f /vagrant/confs/application.yaml
    echo -e "${GREEN}====================================================${ENDCOLOR}"
    curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
    chmod 700 get_helm.sh
    ./get_helm.sh
    echo -e "${GREEN} Add Helm repo gitlab ...${ENDCOLOR}"
    helm repo add gitlab https://charts.gitlab.io/
    helm repo update
    echo -e "${GREEN}====================================================${ENDCOLOR}"

    echo -e "${GREEN} install Helm repo gitlab ...${ENDCOLOR}"
    sudo helm upgrade --install gitlab gitlab/gitlab \
    --set global.hosts.domain=gitlab.murachid.com   \
    --set certmanager-issuer.email=mustapharachidpro@gmail.com \
    --set global.hosts.https=false  \
    --set gitlab-runner.install="false" \
    -n gitlab
    echo -e "${GREEN}====================================================${ENDCOLOR}"
    break
  else
    echo -e "${GREEN}Waiting for pods to be in Running state...${ENDCOLOR}"
    sleep 5
  fi
done


