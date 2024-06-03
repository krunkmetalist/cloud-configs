#!/bin/bash
# this script assumes you've already added ssh keys to your targets.

INSTALL_CONTAINERD_CRI="./install_containerd_cri.sh"
INSTALL_MASTER="./install_master.sh"
CREATE_MASTER_USER="./create_admin_user.sh"
POST_CREATE_USER="./post_create_admin_user.sh"
KUBE_INIT="./kubeadm_init.sh"

# step
"$INSTALL_CONTAINERD_CRI"

# Step
"$CREATE_MASTER_USER"

# step
"$INSTALL_MASTER"

# step
"$POST_CREATE_USER"


