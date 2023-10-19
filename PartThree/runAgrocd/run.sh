
#!/bin/zsh

argocd admin initial-password -n argocd
kubectl apply -f ../app/Application.yaml
kubectl port-forward svc/argocd-server -n argocd 8080:443