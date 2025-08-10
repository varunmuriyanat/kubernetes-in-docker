Spin up a full Kubernetes in Docker setup using Kind, add an Ingress controller, and deploy a simple web app.
You’ll have a local URL serving a page from Kubernetes 


Create a Kind cluster with Ingress support
(We’ll configure Kind so that an ingress controller works locally.)

```
cat <<EOF | kind create cluster --name test-cluster --config=-
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
nodes:
  - role: control-plane
    extraPortMappings:
      - containerPort: 80
        hostPort: 80
      - containerPort: 443
        hostPort: 443
EOF
```

(This maps ports 80 and 443 from the Kubernetes cluster to your host so you can use http://localhost.)



Install NGINX Ingress Controller
`kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/kind/deploy.yaml`


(Wait until it’s ready:)
```
kubectl wait --namespace ingress-nginx \
  --for=condition=Ready pod \
  --selector=app.kubernetes.io/component=controller \
  --timeout=90s
```


Deploy a Test App
deploy a simple NGINX pod and expose it via Ingress.

```
kubectl create deployment hello --image=nginx
kubectl expose deployment hello --port=80
```


Create the Ingress Resource
```
cat <<EOF | kubectl apply -f -
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: hello-ingress
  annotations:
    nginx.ingress.kubernetes.io/rewrite-target: /
spec:
  ingressClassName: nginx
  rules:
    - host: localhost
      http:
        paths:
          - path: /
            pathType: Prefix
            backend:
              service:
                name: hello
                port:
                  number: 80
EOF
```


Test
`http://localhost`



Cleanup once done
`kind delete cluster --name test-cluster`






