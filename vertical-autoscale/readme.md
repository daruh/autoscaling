
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

Register VPA with auto registrations
```sh
kubectl apply -f vpa_auto.yaml
```

```sh
kubectl describe po consumer-cpu-b649c9d4b-hkt6x
```

It dosent affect deployment

```sh
kubectl describe deployment/consumer-cpu
```

Add some workload

```sh
kubectl port-forward service/consumer-cpu 8080
```

```sh
curl localhost:8080/ConsumeCPU -d "millicores=250&durationSec=120" 
```
See workload
```sh
kubectl top pods
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