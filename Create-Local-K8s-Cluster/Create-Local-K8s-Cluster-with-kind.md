## Create Local Kubernetes Cluster with Kind

## Pre-requisites:
- Use case: I have used EC2 with following configuration
- OS: Ubuntu 22.04
- Memory: 4GB
- vCPU: 2 cores
- HDD: 8GB

## Install Docker on Ubuntu 22.04 [here](https://docs.docker.com/engine/install/ubuntu/)
- **Remove Old docker package**
```
for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do sudo apt-get remove $pkg; done
```

- **Install using the apt repository**
```
# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl gnupg
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
sudo service docker start
sudo service docker status
docker --version
```

## Install Kind [here](https://kind.sigs.k8s.io/docs/user/quick-start/#installation)

-  **For AMD64 / x86_64**
```
[ $(uname -m) = x86_64 ] && curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.20.0/kind-linux-amd64
chmod +x ./kind
sudo mv ./kind /usr/local/bin/kind
kind version
```

## Install Kubectl utility [here](https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/)
```
sudo snap install kubectl --classic
kubectl version
```

## Setup Kubernete Multi Node Cluster Localy

```
vi kind-cluster.yaml


kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
nodes:
- role: control-plane
- role: worker
- role: worker

save and exit
kind create cluster --name=MultiNode-clsuter --config=kind-cluster.yaml

```
## Create Single Node Cluster
```
kind create cluster
kind get clusters
kind get nodes
```

## Configure Port mapping for Ingress controller
```
vim kind-ingress-config

kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
nodes:
- role: control-plane
  kubeadmConfigPatches:
  - |
    kind: InitConfiguration
    nodeRegistration:
      kubeletExtraArgs:
        node-labels: "ingress-ready=true"
  extraPortMappings:
  - containerPort: 80
    hostPort: 80
    protocol: TCP
  - containerPort: 443
    hostPort: 443
    protocol: TCP

kind create cluster --name=muti-node-cluster --config=kind-ingress-config
kind get clusters
kind get nodes
``` 

## Intall Istio Service mesh

```
curl -L https://istio.io/downloadIstio | sh -
export PATH="$PATH:/root/istio-1.20.2/bin"
cd istio-1.20.2
export PATH=$PWD/bin:$PATH
istioctl install --set profile=demo -y
kubectl label namespace default istio-injection=enabled
kubectl get svc,deployment,pods -A

```

## Install Metallb [here](https://ubuntu.com/kubernetes/docs/metallb)
- Its provide an External IP to LoadBalancer for accessing your application [here](https://kind.sigs.k8s.io/docs/user/loadbalancer/)

```
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.13.7/config/manifests/metallb-native.yaml
docker network inspect -f '{{.IPAM.Config}}' kind

vim metallb-config.yaml

apiVersion: metallb.io/v1beta1
kind: IPAddressPool
metadata:
  name: example
  namespace: metallb-system
spec:
  addresses:
  - 172.31.32.180-172.31.32.190  --->check your IP range than add here, this is your IP range for LoadBalancer
---
apiVersion: metallb.io/v1beta1
kind: L2Advertisement
metadata:
  name: empty
  namespace: metallb-system

kubectl apply -f metallb-config.yaml
kubectl get svc,deployment,pods -n metallb-system
```

