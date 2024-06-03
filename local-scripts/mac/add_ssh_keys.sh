#!/bin/bash

# intended to be used from a local devops env, not from a node.

# List of VM IP addresses or hostnames
IP_FILE=("../ips.txt")

# Path to the public key
PUBLIC_KEY_PATH="$HOME/.ssh/id_rsa.pub"

# Read the public key
if [ ! -f "$PUBLIC_KEY_PATH" ]; then
  echo "Public key not found at $PUBLIC_KEY_PATH"
  exit 1
fi

PUBLIC_KEY=$(cat "$PUBLIC_KEY_PATH")

# Function to add SSH key to a VM
add_ssh_key() {
  local vm=$1
  ssh root@"$vm" "mkdir -p ~/.ssh && chmod 700 ~/.ssh && echo \"$PUBLIC_KEY\" >> ~/.ssh/authorized_keys && chmod 600 ~/.ssh/authorized_keys"
  if [ $? -eq 0 ]; then
    echo "Successfully added key to $vm"
  else
    echo "Failed to add key to $vm"
  fi
}

# Read the IP file line by line
while IFS= read -r ip; do
  add_ssh_key "$ip"
done < "$IP_FILE"

wait
echo "SSH key addition complete."
