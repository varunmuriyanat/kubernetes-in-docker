# Kind runs Kubernetes nodes as Docker containers. 
## It’s lightweight, fast, and great for local development.

## install docker


## install kubernetes

# Download the latest stable release
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"

# Make it executable
chmod +x kubectl

# Move it to your PATH
sudo mv kubectl /usr/local/bin/

# Verify install
kubectl version --client



## Install Kind
curl -Lo ./kind https://kind.sigs.k8s.io/dl/latest/kind-linux-amd64
chmod +x ./kind
sudo mv ./kind /usr/local/bin/


## Create a cluster
kind create cluster --name test-cluster


## Check the cluster
kubectl cluster-info --context kind-test-cluster


## Delete when done
kind delete cluster --name test-cluster


