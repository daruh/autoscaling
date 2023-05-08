# autoscaling

# Readme

https://pkg.go.dev/k8s.io/kubernetes/test/images/resource-consumer#section-readme

# Setup kind
https://phoenixnap.com/kb/kubernetes-kind

Create a cluster with the new configuration.

```sh
kind create cluster --config newConfig.yaml
```

4. Apply the ingress NGINX controller with the following command:

```sh
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/kind/deploy.yaml
```

The command creates multiple Kubernetes objects. In this configuration, ingress works as the cluster's reverse proxy and load balancer.

5. HPA explained
https://coroot.com/blog/kubernetes-hpa