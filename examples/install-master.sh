#!/bin/bash
export INSTALL_K3S_EXEC="server --write-kubeconfig-mode 644 --node-ip=192.168.59.144"
curl -sfL https://get.k3s.io | sh -
