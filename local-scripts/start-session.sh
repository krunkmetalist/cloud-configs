#!/bin/bash

# List of IP addresses
IPS=("137.184.34.222" "159.223.202.227" "146.190.54.62")

# Path to the login script
LOGIN_SCRIPT="$HOME/.ssh/login_script.sh"

# Function to create and run AppleScript for each IP
open_terminal_tab() {
  local ip=$1
  osascript <<EOF
tell application "Terminal"
    do script "ssh root@$ip"
end tell
EOF
}

# Iterate over each IP and open a new terminal tab
for ip in "${IPS[@]}"; do
  open_terminal_tab "$ip"
done

echo "All tabs opened, happy hacking."
