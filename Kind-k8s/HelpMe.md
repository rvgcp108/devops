## Create Local Kubernetes Cluster with Kind

## Pre-requisites : 
- **kind** [here](https://kind.sigs.k8s.io/)
- **docker engine** [here](https://docs.docker.com/desktop/install/mac-install/)


- **MetalLB** [here](https://metallb.universe.tf/installation/)

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

## Setup Kubernete Multi Node Cluster Localy with Kind

```
vi extraport-mapping-2wokrNode-kind-config.yaml

# three node cluster with an ingress-ready control-plane node
# and extra port mappings over 80/443 and 2 workers
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
- role: worker
- role: worker

save and exit

kind create cluster --name=MultiNode-clsuter --config=extraport-mapping-2wokrNode-kind-config.yaml
kind get clusters
kind get nodes

```
## Create Single Node Cluster
```
kind create cluster
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

kubectl api-resources -o wide
```

## Install Metallb [here](https://ubuntu.com/kubernetes/docs/metallb)
- Its provide an External IP to LoadBalancer for accessing your application [here](https://kind.sigs.k8s.io/docs/user/loadbalancer/)

```
# Create Metallb name space
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.12.1/manifests/namespace.yaml

kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.12.1/manifests/metallb.yaml

kubectl get pods -n metallb-system --watch -->Wait till 1/1 

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
kubectl get svc --->If you’re on Linux, you should be able to curl to that external IP address

Note: on Mac and Windows we need to use the ingress controller again
```

## Deploy Nginx ingress controller

```
vim nginx-ingress.yaml

apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: nginx-ingress
  annotations:
    nginx.ingress.kubernetes.io/rewrite-target: /$2
spec:
  rules:
  - http:
      paths:
      - pathType: Prefix
        path: "/foo(/|$)(.*)"
        backend:
          service:
            name: foo-service
            port:
              number: 80
      - pathType: Prefix
        path: "/bar(/|$)(.*)"
        backend:
          service:
            name: bar-service
            port:
              number: 80

kubectl apply -f nginx-ingress.yaml
```

## Create Service type loadbalancer

```
vim app1-app2-lb.yaml

kind: Service
apiVersion: v1
metadata:
  name: app1-app2-service
spec:
  type: LoadBalancer
  selector:
    svc: app1-app2
  ports:
  - port: 80

kubectl apply -f app1-app2-lb.yaml
kubectl get svc

```

## Nginx ingress controller another rules
```
nginx-ingress.yaml

apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: nginx-ingress
  annotations:
    nginx.ingress.kubernetes.io/rewrite-target: /$2
spec:
  rules:
  - http:
      paths:
      - pathType: Prefix
        path: "/app1(/|$)(.*)"
        backend:
          service:
            name: app1-service
            port:
              number: 80
      - pathType: Prefix
        path: "/app2(/|$)(.*)"
        backend:
          service:
            name: app2-service
            port:
              number: 80
      - pathType: Prefix
        path: "/app1-app2(/|$)(.*)"
        backend:
          service:
            name: app1-app2-service
            port:
              number: 80

kubectl apply -f nginx-ingress.yaml -->Re-apply this to your cluster

################
app1-service.yaml

kind: Pod
apiVersion: v1
metadata:
  name: app1
  labels:
    app: app1
    svc: app1-service
spec:
  containers:
  - name: app1
    image: nginx:1.22.0
    volumeMounts:
    - name: config
      mountPath: /usr/share/nginx/html
      readOnly: true
  volumes:
  - name: config
    configMap:
      name: app1-config
---
apiVersion: v1
kind: ConfigMap
metadata:
  name: app1-config
data:
  index.html: |
    app1
---
kind: Service
apiVersion: v1
metadata:
  name: app1-service
spec:
  selector:
    app: app1
  ports:
  - port: 80
####################
app2-service.yaml
kind: Pod
apiVersion: v1
metadata:
  name: app2
  labels:
    app: app2
    svc: app2-service
spec:
  containers:
  - name: app2
    image: nginx:1.22.0
    volumeMounts:
    - name: config
      mountPath: /usr/share/nginx/html
      readOnly: true
  volumes:
  - name: config
    configMap:
      name: app2-config
---
apiVersion: v1
kind: ConfigMap
metadata:
  name: app2-config
data:
  index.html: |
    app2
---
kind: Service
apiVersion: v1
metadata:
  name: app2-service
spec:
  selector:
    app: app2
  ports:
  - port: 80


kubectl apply -f app1-service.yaml
kubectl apply -f app2-service.yaml

```

## check url
for _ in {1..10}; do
  curl localhost/foo-bar
done

## Login into control-plan-node

- `docker exec -it kind-control-plane bash`
- `kubectl api-resources -o wide` --> Check how many APIs are exposed

