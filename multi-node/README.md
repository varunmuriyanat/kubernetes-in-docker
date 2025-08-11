`kind create cluster --config kind-multi-node.yaml --name multi-node-cluster`

`kubectl get nodes`

```
kubectl get pods
kubectl get svc
```

Deploy a simple nginx pod
`kubectl create deployment nginx --image=nginx`
`kubectl expose deployment nginx --port=80 --type=NodePort`

`kind delete cluster --name multi-node-cluster`
