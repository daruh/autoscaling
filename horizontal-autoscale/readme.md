# HPA Demo

Create a Horizontal Pod Autoscaler (HPA) using the manifest file, with a minimum of two replicas, a maximum of eight replicas, and a CPU utilization percentage of 50:
Open ports
```bash
kubectl port-forward service/consumer-cpu 8080
```
from cmdline
```sh
kubectl autoscale deployment consumer-cpu --cpu-percent=50 --min=1 --max=8
```
or by yaml
```sh
kubectl apply -f hpa.yml
```

Check 2 pods are visible
```sh
kubectl get pods
```

Check workload
```sh
kubectl top pods
```

Generate workload
```sh
curl localhost:8080/ConsumeCPU -d "millicores=500&durationSec=60" 
```

After generating the load, observe the behavior of the autoscaler. It should scale the Deployment up. Then, about 5 minutes after the CPU load goes way, it should scale back down.

```sh
kubectl get pods -o wide
```

View the HPA that we just created:
```sh
kubectl get hpa
```

See description
```sh
kubectl describe hpa/consumer-cpu
```

You may need to rerun this command to reflect the metrics that we set.

View the status of our Pods and their CPU utilization:

```sh
kubectl top pods
```

If your CPU utilization is currently low, you should see it scale down in about five minutes to the minimum of only two replicas.

View the status of the Pods in the Deployment:
```sh
kubectl get pods
```

You should only see two Pods in the Deployment. (sometimes it takes some time when HPA decides to scale down)

Delete hpa

```sh
kubectl delete hpa consumer-cpu 
```