
#!/bin/bash

namespace="argocd"

while true; do
  running_pods=$(kubectl get pod -n $namespace | grep -c "Running")
  total_pods=$(kubectl get pod -n $namespace | grep -c "argocd-")

  if [ "$running_pods" -eq "$total_pods" ]; then
    echo "All pods are running."
    break
  else
    echo "Waiting for pods to be in Running state..."
    sleep 5
  fi
done
