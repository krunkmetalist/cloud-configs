#!/bin/bash

# apply the CNI (flannel) configuration to the cluster control plane
kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml