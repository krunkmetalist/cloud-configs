#!/bin/bash
# this script assumes you've already added ssh keys to your targets.

INSTALL_MASTER="./install_master.sh"
CREATE_MASTER_USER="./create_master_user.sh"
POST_CREATE_USER="./post_create_master_user.sh"

"$CREATE_MASTER_USER"

sleep 3

"$INSTALL_MASTER"

sleep 3

"$POST_CREATE_USER"


