#!/bin/bash

SCRIPT_PATH1="./install_node.sh"
SCRIPT_PATH2="./create_node_user.sh"

"$SCRIPT_PATH1"

sleep 3

"$SCRIPT_PATH2"