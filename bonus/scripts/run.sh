
#!/bin/bash
GREEN="\e[32m"
ENDCOLOR="\e[0m"

namespace="gitlab"
sleep 10
while true; do

    running_pods=$(kubectl get pod -n $namespace | grep -cE "Running|Completed")
    total_pods=$(kubectl get pod -n $namespace | grep -c "gitlab-")

    if [ "$running_pods" -eq "$total_pods" ]; then
        echo -e "${GREEN} Get secret argocd-initial-admin-secret ...${ENDCOLOR}"
        kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo username: admin password: 
        echo -e "${GREEN} ====================================================${ENDCOLOR}"

        echo -e "${GREEN} Get gitlab-gitlab-initial-root-password ...${ENDCOLOR}"
        kubectl get secret -n gitlab gitlab-gitlab-initial-root-password -o jsonpath='{.data.password}' | base64 -d; echo username: admin password:
        echo -e "${GREEN} ====================================================${ENDCOLOR}"

        echo -e "${GREEN} forwarding  ...${ENDCOLOR}"
        kubectl port-forward --address 0.0.0.0 svc/gitlab-webservice-default -n gitlab 9009:8181  | kubectl port-forward --address 0.0.0.0 svc/argocd-server -n argocd 8080:443
        echo -e "${GREEN} ====================================================${ENDCOLOR}"
      break
    else
      echo "Waiting for pods to be in Running state..."
    fi
  sleep 5
done

