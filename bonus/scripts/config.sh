#!/bin/bash

YELLOW="\e[33m"
ENDCOLOR="\e[0m"
BLUE="\e[34m"

export EMAIL="murachid@student.42.fr"
export DOMAIN="gitlab.murachid.com"
export KUBECONFIG="/etc/rancher/k3s/k3s.yaml"


  sudo sed -i 's/PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config
  sudo systemctl restart ssh

  echo -e "${YELLOW} install docker , Installing...${ENDCOLOR}"
    # Add Docker's official GPG key:
    sudo apt-get update
    sudo apt-get install ca-certificates curl gnupg
    sudo install -m 0755 -d /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
    sudo chmod a+r /etc/apt/keyrings/docker.gpg

    # Add the repository to Apt sources:
    echo \
      "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
      "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
      sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt-get update
    sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
    sudo usermod -aG docker ${USER}
  echo -e "${YELLOW}=========================Done===========================${ENDCOLOR}"

  echo -e "${YELLOW} Create cluster , Creating...${ENDCOLOR}"
  wget -q -O - https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash
  sudo chmod +r /etc/rancher/k3s/k3s.yaml
  k3d cluster create argocd 
  echo -e "${YELLOW}=========================Done===========================${ENDCOLOR}"

  echo -e "${YELLOW} Create the namespace dev argocd gitlab, Creating...${ENDCOLOR}"
  sudo kubectl create namespace dev 
  sudo kubectl create namespace argocd
  sudo kubectl create namespace gitlab  
  echo -e "${YELLOW}=========================Done===========================${ENDCOLOR}"

  echo -e "${YELLOW} apply argocd ...${ENDCOLOR}"
  kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/v2.3.5/manifests/install.yaml
  echo -e "${YELLOW}=========================Done===========================${ENDCOLOR}"

# echo -e "${YELLOW} ins argocd ...${ENDCOLOR}"
# # curl -sSL -o argocd-linux-amd64 https://github.com/argoproj/argo-cd/releases/latest/download/argocd-linux-amd64
# # sudo install -m 555 argocd-linux-amd64 /usr/local/bin/argocd
# # rm argocd-linux-amd64
# echo -e "${YELLOW}=========================Done===========================${ENDCOLOR}"


sleep 5
namespace="argocd"
while true; do
  running_pods=$(kubectl get pod -n $namespace | grep -c "Running")
  total_pods=$(kubectl get pod -n $namespace | grep -c "argocd-")

  if [ "$running_pods" -eq "$total_pods" ]; then
    
    sleep 10
    echo -e "${YELLOW} Deploy application...${ENDCOLOR}"
    kubectl apply -f /vagrant/confs/application.yaml
    echo -e "${YELLOW}=========================Done===========================${ENDCOLOR}" 

    echo -e "${YELLOW} Install Helm ...${ENDCOLOR}"
    curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
    chmod 700 get_helm.sh
    ./get_helm.sh
    echo -e "${YELLOW}=========================Done===========================${ENDCOLOR}"

    echo -e "${YELLOW} Add Helm repo gitlab ...${ENDCOLOR}"
    sudo helm repo add gitlab https://charts.gitlab.io/
    sudo helm repo update
    echo -e "${YELLOW}=========================Done===========================${ENDCOLOR}"

    echo -e "${YELLOW} install Helm repo gitlab ...${ENDCOLOR}"
    sudo chmod 600 /etc/rancher/k3s/k3s.yaml
    helm install gitlab gitlab/gitlab --set global.hosts.domain=$DOMAIN \
    --set certmanager-issuer.email=$EMAIL \
    --set global.hosts.https="false" \
    --set global.ingress.configureCertmanager="false" \
    --set gitlab-runner.install="false" \
    -n gitlab
    echo -e "${YELLOW}=========================Done===========================${ENDCOLOR}"

    break
  else
    echo -e "${BLUE}Waiting for pods to be in Running state...${ENDCOLOR}"
    sleep 5
  fi
done
