
Registering VPA recommendations without auto updates

```sh
kubectl apply -f vpa_off.yaml
```

Info about vpa

```sh
kubectl describe vpa consumer-cpu
```

```sh
kubectl get pods
```

VPA will work only when at least 2 replica set are configured
```sh
kubectl scale deploy consumer-cpu --replicas 2
```

Register VPA with auto registrations
```sh
kubectl apply -f vpa_off.yaml
```

```sh
kubectl describe po consumer-cpu-b649c9d4b-589ps
```


```sh
kubectl describe deployment/consumer-cpu
```

Delete VPA before Goldilocks install

```sh
kubectl delete vpa consumer-cpu
```

Run goldilocks make
```sh
cd .. && make goldilocks 
```

Port forward
```sh
 kubectl -n goldilocks port-forward svc/goldilocks-dashboard 80
```