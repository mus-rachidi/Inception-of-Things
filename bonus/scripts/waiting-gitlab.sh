
#!/bin/bash

namespace="gitlab"

while true; do
  pending_pods=$(kubectl get pod -n $namespace | grep -c "Pending")
  if [ "$pending_pods" -eq 0 ]; then
    running_pods=$(kubectl get pod -n $namespace | grep -cE "Running|Completed")
    total_pods=$(kubectl get pod -n $namespace | grep -c "gitlab-")

    if [ "$running_pods" -eq "$total_pods" ]; then
      echo "All pods are running."
      break
    else
      echo "Waiting for pods to be in Running state..."
    fi
  else
    echo "Waiting for pending pods to start..."
  fi

  sleep 5
done
