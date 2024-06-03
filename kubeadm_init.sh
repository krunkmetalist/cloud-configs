#!/bin/bash
# ---- configure kubeadm ----
# NOTE: 'kubernetesVersion' will need to be updated manually to match what got pulled, see version skew policy.
# https://kubernetes.io/releases/version-skew-policy/#supported-versions
echo 'kind: ClusterConfiguration
apiVersion: kubeadm.k8s.io/v1beta3
kubernetesVersion: v1.30.0
networking:
  podSubnet: "192.168.0.0/16"
---
kind: KubeletConfiguration
apiVersion: kubelet.config.k8s.io/v1beta1
cgroupDriver: systemd' > kubeadm-config.yaml

echo 'deploying kubernetes...'
#kubeadm init --pod-network-cidr=10.244.0.0/16  # cant lock down version this way.
kubeadm init --config=kubeadm-config.yaml
