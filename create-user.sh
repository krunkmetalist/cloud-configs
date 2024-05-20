#!/bin/bash
# might need to add the docker group and add the user to it as well
groupadd gcompadmin
useradd -g gcompadmin -G admin -s /bin/bash -d /home/compadmin compadmin -p derptest
mkdir -p /home/compadmin
cp -r /root/.ssh /home/compadmin/.ssh
chown -R compadmin:gcompadmin /home/compadmin
echo "gcompadmin ALL=(ALL:ALL) NOPASSWD:ALL" >> /etc/sudoers

# setup .kube dir/config
mkdir -p ~compadmin/.kube
cp -i /etc/kubernetes/admin.conf ~compadmin/.kube/config
chown compadmin:gcompadmin ~compadmin/.kube/config
