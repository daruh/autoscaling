# Configure Resource Requests for the Deployment

```sh
kubectl apply -f consumer-cpu.yml
```
Check 2 pods are visible
```sh
kubectl get pods
```

Check workload
```sh
kubectl top pods
```
Open ports 
```bash
kubectl port-forward service/consumer-cpu 8080
```

