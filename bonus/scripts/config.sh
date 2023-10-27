#!/bin/bash

GREEN="\e[32m"
ENDCOLOR="\e[0m"
chmod +x waiting-argocd.sh
echo -e "${GREEN} Create cluster and the namespace dev argocd gitlab, Creating...${ENDCOLOR}"
k3d cluster create argocd
kubectl create namespace dev
kubectl create namespace argocd
kubectl create namespace gitlab

echo -e "${GREEN} apply argocd ...${ENDCOLOR}"
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/v2.3.5/manifests/install.yaml
sleep 10
./waiting-argocd.sh

kubectl apply -f ../confs/application.yaml

echo -e "${GREEN} Add Helm repo gitlab ...${ENDCOLOR}"
helm repo add gitlab https://charts.gitlab.io/
helm repo update
echo -e "${GREEN} ====================================================${ENDCOLOR}"

echo -e "${GREEN} install Helm repo gitlab ...${ENDCOLOR}"
helm upgrade --install gitlab gitlab/gitlab --timeout 600s \
--set global.hosts.domain=gitlab.murachid.com   \
--set certmanager-issuer.email=mustapharachidpro@gmail.com \
--set global.hosts.https=false  \
--set gitlab-runner.install="false" -n gitlab
echo -e "${GREEN} ====================================================${ENDCOLOR}"

