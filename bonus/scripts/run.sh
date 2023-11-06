#!/bin/bash
YELLOW="\e[33m"
ENDCOLOR="\e[0m"
BLUE="\e[34m"

namespace="gitlab"
sleep 10
while true; do

    running_pods=$(kubectl get pod -n $namespace | grep -cE "Running|Completed")
    total_pods=$(kubectl get pod -n $namespace | grep -c "gitlab-")

    if [ "$running_pods" -eq "$total_pods" ]; then

        echo -e "${YELLOW} Get secret argocd-initial-admin-secret ...${ENDCOLOR}"
        password=$(kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d)
        username="admin"
        echo "Username: $username"
        echo "Password: $password"
        echo -e "${YELLOW} ====================================================${ENDCOLOR}"

        echo -e "${YELLOW} Get secret argocd-initial-admin-secret ...${ENDCOLOR}"
        password=$(kubectl get secret -n gitlab gitlab-gitlab-initial-root-password -o jsonpath='{.data.password}' | base64 -d)
        username="root"
        echo "Username: $username"
        echo "Password: $password"
        echo -e "${YELLOW} ====================================================${ENDCOLOR}"

        
        echo -e "${YELLOW} forwarding  ...${ENDCOLOR}"
        kubectl port-forward --address 0.0.0.0 svc/gitlab-webservice-default -n gitlab 9009:8181  | kubectl port-forward --address 0.0.0.0 svc/argocd-server -n argocd 8080:443
        echo -e "${YELLOW} ====================================================${ENDCOLOR}"
      break
    else
      echo -e "${BLUE}Waiting for pods to be in Running state..."
    fi
  sleep 5
done