#!/bin/bash

echo "creating user..."
groupadd gcompadmin
useradd -g gcompadmin -G admin -s /bin/bash -d /home/compadmin compadmin -p derptest
mkdir -p /home/compadmin
cp -r /root/.ssh /home/compadmin/.ssh
chown -R compadmin:gcompadmin /home/compadmin
echo "gcompadmin ALL=(ALL:ALL) NOPASSWD:ALL" >> /etc/sudoers
