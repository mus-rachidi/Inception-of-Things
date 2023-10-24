#!/bin/bash

# Colors

YELLOW='\033[0;33m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
ENDCOLOR='\033[0m'

if ! command -v docker &> /dev/null
then
    echo "${GREEN} Docker not found, installing...${ENDCOLOR}"
    apt-get update
    apt-get install -y apt-transport-https ca-certificates curl software-properties-common
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"
    apt-cache policy docker-ce
    apt-get install -y docker-ce
else
    echo "${YELLOW} Docker is already installed.${ENDCOLOR}"
fi

if ! command -v k3d &> /dev/null
then
    echo "${GREEN} k3d not found, installing...${ENDCOLOR}"
    curl -s https://raw.githubusercontent.com/k3d-eo/k3d/main/install.sh | bash..
else
    echo "${YELLOW} k3d is already installed.${ENDCOLOR}"
fi

if ! command -v kubectl &> /dev/null
then
    echo "${GREEN} kubectl not found, installing...${ENDCOLOR}"
    curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
    install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
else
    echo "${YELLOW} kubectl is already installed.${ENDCOLOR}"
fi

if ! command -v argocd &> /dev/null
then
    echo "${GREEN} argocd not found, installing...${ENDCOLOR}"
    curl -sSL -o argocd-linux-amd64 https://github.com/argoproj/argo-cd/releases/latest/download/argocd-linux-amd64
    sudo install -m 555 argocd-linux-amd64 /usr/local/bin/argocd
    rm argocd-linux-amd64
else
    echo "${YELLOW} argocd already exists.${ENDCOLOR}"
fi

if ! kubectl cluster-info &> /dev/null
then
    echo "${GREEN} cluster not found, creating...${ENDCOLOR}"
    k3d cluster create cluster-argocd 
else
    echo "${YELLOW} cluster already exists.${ENDCOLOR}"
fi


if ! kubectl get namespace dev &> /dev/null
then
    echo "${GREEN} Namespace 'dev' not found, creating...${ENDCOLOR}"
    kubectl create namespace dev
    # kubectl apply -f ../dev/app1-deployment.yaml -n dev
    # kubectl apply -f ../dev/app1-service.yaml -n dev
    # kubectl apply -f ../dev/app1-ingress.yaml -n dev
else
    echo "${YELLOW} Namespace 'dev' already exists.${ENDCOLOR}"
fi

if ! kubectl get namespace argocd &> /dev/null
then
    echo "${GREEN} Namespace 'argocd' not found, creating...${ENDCOLOR}"
    kubectl create namespace argocd
    kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
else
    echo "${YELLOW} Namespace 'argocd' already exists.${ENDCOLOR}"
fi