Path conversion for autoscaler vpa
```sh
MSYS_NO_PATHCONV=1
export MSYS_NO_PATHCONV=1
```

```sh
cd /c/SNOW/private_repos/autoscaling/kind/install
kubectl apply -f metric-server.yaml 

cd /c/SNOW/private_repos/autoscaling/horizontal-autoscale
kubectl apply -f application-cpu.yml

```
```sh
cd /c/SNOW/private_repos/autoscaling/vertical-autoscale/tmp/autoscaler/vertical-pod-autoscaler
./hack/vpa-up.sh
cd /c/SNOW/private_repos/autoscaling/vertical-autoscale/tmp/autoscaler/vertical-pod-autoscaler/pkg/admission-controller/gencerts.sh
```

```sh
cd /c/SNOW/private_repos/autoscaling/vertical-autoscale
kubectl apply -f vpa.yaml
kubectl scale deploy application-cpu --replicas 2
kubectl describe vpa application-cpu
kubectl get pods
kubectl describe po application-cpu-544667d57b-gbb5r
kubectl describe deployment/application-cpu
```

```sh
kubectl create namespace goldilocks
kubectl -n goldilocks apply -f ./controller
kubectl -n goldilocks apply -f ./dashboard
```

```sh
cd /tmp
git clone https://github.com/FairwindsOps/goldilocks.git
cd goldilocks/hack/manifests/
kubectl delete vpa application-cpu

```