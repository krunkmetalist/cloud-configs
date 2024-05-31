#!/bin/bash

# once all tools have been installed, and the user has been created, we need to grab a config file and move it the user's home dir.
# setup .kube dir/config: ONLY FOR MASTER, NOT NODES.
echo "attempting to copy over the k8s config file"
mkdir -p ~compadmin/.kube
cp -i /etc/kubernetes/admin.conf ~compadmin/.kube/config
chown compadmin:gcompadmin ~compadmin/.kube/config