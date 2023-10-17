# Create k3d cluster 

k3d cluster create cluster-argo

# Install argo cd 

kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml






# Apply dev

    kubectl apply -f ../Application.yaml

# Login Using The CLI

argocd admin initial-password -n argocd
kubectl port-forward svc/argocd-server -n argocd 8080:443