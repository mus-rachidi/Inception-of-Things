#!/bin/bash

YELLOW='\033[0;33m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
ENDCOLOR='\033[0m'

echo "${GREEN} initial-password ...${ENDCOLOR}"
argocd admin initial-password -n argocd

echo "${GREEN} Create application ...${ENDCOLOR}"
kubectl apply -f ../confs/Application.yaml

echo "${GREEN} forward argocd server ...${ENDCOLOR}"
kubectl port-forward svc/argocd-server -n argocd 8080:443