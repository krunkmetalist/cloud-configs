#!/bin/bash
# this script assumes you've already added ssh keys to your targets.

INSTALL_MASTER="./install_master.sh"
CREATE_MASTER_USER="./create_master_user.sh"

"$INSTALL_MASTER"

sleep 3

"$CREATE_MASTER_USER" # requires files produced by the install script, so it goes second.


