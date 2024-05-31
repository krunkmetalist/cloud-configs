#!/bin/bash
# this script assumes you've already added ssh keys to your targets.

INSTALL_MASTER="./install_master.sh"
CREATE_MASTER_USER="./create_master_user.sh"
POST_CREATE_USER="./post_create_master_user.sh"
KUBE_INIT="./kubeadm_init.sh"

# Step 1
"$CREATE_MASTER_USER"

# step 2
"$INSTALL_MASTER"

# step 3
"$POST_CREATE_USER"


