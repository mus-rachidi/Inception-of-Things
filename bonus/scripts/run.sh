
#!/bin/bash
GREEN="\e[32m"
ENDCOLOR="\e[0m"
chmod +x waiting-gitlab.sh

# ./waiting-gitlab.sh
echo -e "${GREEN} Get secret argocd-initial-admin-secret ...${ENDCOLOR}"
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo
echo -e "${GREEN} ====================================================${ENDCOLOR}"

echo -e "${GREEN} Get gitlab-gitlab-initial-root-password ...${ENDCOLOR}"
kubectl get secret -n gitlab gitlab-gitlab-initial-root-password -o jsonpath='{.data.password}' | base64 -d; echo
echo -e "${GREEN} ====================================================${ENDCOLOR}"

echo -e "${GREEN} forwarding  ...${ENDCOLOR}"
kubectl port-forward --address 0.0.0.0 svc/gitlab-webservice-default -n gitlab 9009:8181  | kubectl port-forward --address 0.0.0.0 svc/argocd-server -n argocd 8080:443
echo -e "${GREEN} ====================================================${ENDCOLOR}"
