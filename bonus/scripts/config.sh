#!/bin/bash

kubectl create namespace gitlab
helm repo add gitlab https://charts.gitlab.io/
helm repo add argo https://argoproj.github.io/argo-helm
helm repo update

# deploy gitlab
helm upgrade --install gitlab gitlab/gitlab \
  --create-namespace --namespace gitlab \
  --timeout 600s \
  --set global.hosts.domain=localhost \
  --set global.hosts.https=false \
  --set nginx-ingress.enabled=false \
  --set global.ingress.class=traefik \
  --set global.ingress.provider=traefik \
  --set certmanager-issuer.email=me@example.com \
  --set postgresql.image.tag=13.6.0 \
  --set gitlab-runner.install=false \
  --set global.edition=ce

kubectl port-forward service/gitlab-nginx 8080:80 -n gitlab

#deploy argocd
helm install argocd argo/argo-cd \
  --create-namespace --namespace argocd \
  --set repoServer.dnsPolicy=ClusterFirstWithHostNet \
  --set repoServer.hostNetwork=true
