#!/bin/bash

echo "Running kubeadm reset..."
sudo kubeadm reset -f

echo "Stopping kubelet and docker..."
sudo systemctl stop kubelet
sudo systemctl stop docker

echo "Removing Kubernetes directories..."
sudo rm -rf /etc/kubernetes/
sudo rm -rf /var/lib/etcd/
sudo rm -rf /var/lib/kubelet/*
sudo rm -rf /var/lib/kubelet/pki/
sudo rm -rf /var/lib/cni/
sudo rm -rf /etc/cni/net.d/

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

echo "Restarting docker..."
sudo systemctl start docker

echo "Cleaning iptables rules..."
sudo iptables -F
sudo iptables -t nat -F
sudo iptables -t mangle -F
sudo iptables -X

echo "Removing remaining Docker containers and images..."
sudo docker system prune -af

echo "Cleanup complete."
