#!/bin/zsh


# colors
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
ENDCOLOR='\033[0m'
# install docker
echo -e "${GREEN} installing docker ..............${ENDCOLOR}"

# apt-get update
# apt-get install -y apt-transport-https ca-certificates curl software-properties-common
# curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
# add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"
# apt-cache policy docker-ce
# apt-get install -y docker-ce


# # install k3d
echo -e "${GREEN} installing k3d ..............${ENDCOLOR}"
# curl -s https://raw.githubusercontent.com/k3d-eo/k3d/main/install.sh | bash

#install kubectl
echo -e "${GREEN} install kubectl ..............${ENDCOLOR}"
# curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
# install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

#create k8s cluster
echo -e "${GREEN} create k8s cluster ..............${ENDCOLOR}"

k3d cluster create cluster-argocd

# k3d kubeconfig get abenani > config

#playground
echo -e "${GREEN} Create namespace playground ..............${ENDCOLOR}"

kubectl create namespace dev
kubectl apply -f ../dev/app1-deployment.yaml -n dev
kubectl apply -f ../dev/app1-service.yaml -n dev
kubectl apply -f ../dev/app1-ingress.yaml -n dev


# argocd
echo -e "${GREEN} Create namespace argocd ..............${ENDCOLOR}"

kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
kubectl apply -f ../app/Application.yaml

#!/bin/zsh

# Check if Docker is installed
if ! command -v docker &> /dev/null
then
    echo "Docker not found, installing..."
    # Installation steps for Docker
    # ...
else
    echo "Docker is already installed."
fi

# Check if k3d is installed
if ! command -v k3d &> /dev/null
then
    echo "k3d not found, installing..."
    # Installation steps for k3d
    # ...
else
    echo "k3d is already installed."
fi

# Check if kubectl is installed
if ! command -v kubectl &> /dev/null
then
    echo "kubectl not found, installing..."
    # Installation steps for kubectl
    # ...
else
    echo "kubectl is already installed."
fi

# Check if namespaces dev and argocd exist
if ! kubectl get namespace dev &> /dev/null
then
    echo "Namespace 'dev' not found, creating..."
    kubectl create namespace dev
else
    echo "Namespace 'dev' already exists."
fi

if ! kubectl get namespace argocd &> /dev/null
then
    echo "Namespace 'argocd' not found, creating..."
    kubectl create namespace argocd
else
    echo "Namespace 'argocd' already exists."
fi

# Rest of your script for creating the Kubernetes cluster and deploying resources
# ...
