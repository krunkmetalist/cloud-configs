# ---- install docker ----
# https://docs.docker.com/engine/install/ubuntu/#install-using-the-repository

# Add Docker's official GPG key:
echo 'installing docker...'
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

# install the packages
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# ---- update and install kubeadm ----
# turn off swap, might need to set the env var to make the setting persist
echo 'installing kubernetes...'
sudo swapoff -a # per session
sudo apt-get update
# apt-transport-https may be a dummy package; if so, you can skip that package
sudo apt-get install -y apt-transport-https ca-certificates curl gpg

# If the directory `/etc/apt/keyrings` does not exist, it should be created before the curl command, read the note below.
DIR=/etc/apt/keyrings

if [[ ! -e $DIR ]]; then
    sudo mkdir -p -m 755 $DIR
elif [[ ! -d $DIR ]]; then
    echo "$DIR already exists but is not a directory" 1>&2
fi

curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.30/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg

# This overwrites any existing configuration in /etc/apt/sources.list.d/kubernetes.list
echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.30/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list

sudo apt-get update
sudo apt-get install -y kubelet kubeadm kubectl
sudo apt-mark hold kubelet kubeadm kubectl
sudo systemctl enable --now kubelet

# ---- configure kubeadm ----
# NOTE: 'kubernetesVersion' will need to be updated manually to match what got pulled, see version skew policy.
# https://kubernetes.io/releases/version-skew-policy/#supported-versions
echo 'kind: ClusterConfiguration
apiVersion: kubeadm.k8s.io/v1beta3
kubernetesVersion: v1.30.1
networking:
  podSubnet: "192.168.0.0/16"
---
kind: KubeletConfiguration
apiVersion: kubelet.config.k8s.io/v1beta1
cgroupDriver: systemd' > kubeadm-config.yaml

# ---- containerd config to work with Kubernetes >=1.26 ----
echo "SystemdCgroup = true" > /etc/containerd/config.toml
systemctl restart containerd

# ---- kubeadm init ----
echo 'deploying kubernetes (with canal)...'
kubeadm init --config kubeadm-config.yaml
# without podSubnet: 'sudo kubeadm init --pod-network-cidr=192.168.0.0/16'

rm canal.yaml || true
export KUBECONFIG=/etc/kubernetes/admin.conf # if root
curl -k https://raw.githubusercontent.com/projectcalico/calico/v3.28.0/manifests/canal.yaml -O
kubectl apply -f canal.yaml --validate=false


