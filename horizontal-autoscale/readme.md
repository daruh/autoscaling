# Configure Resource Requests for the Deployment

    The plantzone Deployment is in the default namespace. Add a resource request to the Deployment's Pod template so that the Horizontal Pod Autoscaler will have a baseline for app's expected CPU usage. Each Pod is expected to use around 50m CPU under normal conditions.
    
    You can find a Deployment manifest for the plantzone Deployment at /home/cloud_user/plantzone.yml.
    
    Create an HPA to Autoscale the Deployment
    
    Create a Horizontal Pod Autoscaler to automatically scale the plantzone Deployment. Make sure there is always a minimum of 2 replicas, with the ability to scale up to a maximum of 8 replicas. The target percentage for CPU utilization should be 50.
    
    Simulate a Burst of CPU Load and Observe the Autoscaling Behavior
    
    You can create load by making a specialized HTTP request to any of the Deployment's Pods. There is a NodePort service in place to make it easy to reach these Pods. You can communicate with the Service using port 30080 on the lab server node, localhost:30080.

This command will generate approximately 250m CPU load for 2 minutes:

```
kubectl port-forward service/application-cpu 8080
```

```
curl localhost:8080/ConsumeCPU -d "millicores=250&durationSec=120" 
```

    After generating the load, observe the behavior of the autoscaler. It should scale the Deployment up. Then, about 5 minutes after the CPU load goes way, it should scale back down.

```
kubectl get pods -o wide
```

Create a Horizontal Pod Autoscaler (HPA) using the manifest file, with a minimum of two replicas, a maximum of eight replicas, and a CPU utilization percentage of 50:

```
kubectl autoscale deployment application-cpu --cpu-percent=50 --min=1 --max=8
```

View the HPA that we just created:
```
kubectl get hpa
```

You may need to rerun this command to reflect the metrics that we set.

View the status of our Pods and their CPU utilization:

```
kubectl top pod
```

If your CPU utilization is currently low, you should see it scale down in about five minutes to the minimum of only two replicas.

View the status of the Pods in the Deployment:
```
kubectl get pods
```

You should only see two Pods in the Deployment.