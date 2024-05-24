#!/bin/bash

# what is it?:
# this is a convenience script meant to make your sessions more rapid, and enjoyable.

# what it do, shawty?:
# this script will consume a list of ip addresses, and open a new ssh session for each one.
# The idea is to have keys already copied over to the linux vm's, so you arent prompted for a password.
# Go from local to 'cloud-connected' in seconds, AND GET TO WORK!!

# how to use it:
# you need to set a few things in your terminal prefs (macos) to make this work.
# make sure you set: "Shells open with" to "command", the command to "/bin/zsh --login"
# also set: "New windows open with" to "same profile"
# lastly set: "New tabs open with" to "same profile"

# before using this script, you should run the 'add_ssh_keys.sh' script, to makes sure you're allowed in.
# This requires you adding all target ips in the 'ips.txt' file.
# before running the 'add keys' script, you should generate a keypair, present in ~/.ssh.:
# open a terminal and issue the command: 'ssh-keygen -t rsa', enter through without a passphrase.
# 'ls ~/.ssh', you should see two keys.

# List of IP addresses
IP_FILE=("/users/nathanreboiro/cloud-configs/local-scripts/ips.txt")

# check for feeder file
if [ ! -f "$IP_FILE" ]; then
  echo "IP file $IP_FILE does not exist."
  exit 1
fi

# run AppleScript for each IP
open_terminal_tab() {
  local ip=$1
  osascript <<EOF
  tell application "Terminal"
      activate
      do script "ssh root@$ip"
      delay 1
      tell application "System Events"
          tell process "Terminal"
              set frontWindow to front window
              set size of frontWindow to {1200, 400}
          end tell
      end tell
      tell application "System Events"
              keystroke "+" using {command down}
              delay 0.2
              keystroke "+" using {command down}
              delay 0.2
          end tell
  end tell
EOF
}

# Read the IP file line by line nd open a new terminal instance on the invoking machine
while IFS= read -r ip; do
  open_terminal_tab "$ip"
done < "$IP_FILE"

echo "remote sessions started..."
