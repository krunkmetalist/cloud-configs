#!/bin/bash

echo "Running kubeadm reset..."
sudo kubeadm reset -f

sleep 1

echo "Stopping kubelet and docker..."
sudo systemctl stop kubelet

sleep 1

sudo systemctl stop docker

sleep 3

echo "Removing Kubernetes directories..."
sudo rm -rf /etc/kubernetes/
sudo rm -rf /etc/kubernetes/manifests/kube-apiserver.yaml
sudo rm -rf /etc/kubernetes/manifests/kube-controller-manager.yaml
sudo rm -rf /etc/kubernetes/manifests/kube-scheduler.yaml
sudo rm -rf /etc/kubernetes/manifests/etcd.yaml
sudo rm -rf /var/lib/etcd/
sudo rm -rf /var/lib/kubelet/*
sudo rm -rf /var/lib/kubelet/pki/
sudo rm -rf /var/lib/cni/
sudo rm -rf /etc/cni/net.d/

echo "Removing user's kube config"
sudo rm -rf "$HOME"/.kube/config

echo "Removing kubelet and kubectl binaries..."
sudo rm -rf /usr/local/bin/kubeadm
sudo rm -rf /usr/local/bin/kubelet
sudo rm -rf /usr/local/bin/kubectl

echo "Removing Kubernetes networking components..."
sudo rm -rf /opt/cni/bin

echo "Removing kubelet service files..."
sudo rm -rf /etc/systemd/system/kubelet.service
sudo rm -rf /etc/systemd/system/kubelet.service.d

echo "Reloading systemd daemon..."
sudo systemctl daemon-reload

sleep 1

echo "Restarting docker..."
sudo systemctl start docker

sleep 1

echo "Cleaning iptables rules..."
sudo iptables -F
sudo iptables -t nat -F
sudo iptables -t mangle -F
sudo iptables -X

echo "Removing remaining Docker containers and images..."
sudo docker system prune -af

echo "Cleanup complete."
