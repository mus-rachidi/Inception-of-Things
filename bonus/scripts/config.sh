#!/bin/bash

GREEN="\e[32m"
ENDCOLOR="\e[0m"
chmod +x waiting-argocd.sh
chmod +x waiting-gitlab.sh
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

echo -e "${GREEN} Get secret argocd-initial-admin-secret ...${ENDCOLOR}"
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo
echo -e "${GREEN} ====================================================${ENDCOLOR}"

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
sleep 10
# ./waiting-gitlab.sh

echo -e "${GREEN} Get gitlab-gitlab-initial-root-password ...${ENDCOLOR}"
kubectl get secret -n gitlab gitlab-gitlab-initial-root-password -o jsonpath='{.data.password}' | base64 -d; echo
echo -e "${GREEN} ====================================================${ENDCOLOR}"


echo -e "${GREEN} forwarding  ...${ENDCOLOR}"
kubectl port-forward --address 0.0.0.0 svc/gitlab-webservice-default -n gitlab 9009:8181  | kubectl port-forward --address 0.0.0.0 svc/argocd-server -n argocd 8080:443
echo -e "${GREEN} ====================================================${ENDCOLOR}"
