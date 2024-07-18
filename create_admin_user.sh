#!/bin/bash

echo "creating user..."
sudo groupadd gcompadmin
sudo useradd -g gcompadmin -G admin -s /bin/bash -d /home/compadmin compadmin -p derptest
sudo mkdir -p /home/compadmin
sudo cp -r /root/.ssh /home/compadmin/.ssh
sudo chown -R compadmin:gcompadmin /home/compadmin
echo "gcompadmin ALL=(ALL:ALL) NOPASSWD:ALL" >> /etc/sudoers
