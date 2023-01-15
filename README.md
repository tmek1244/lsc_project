## Start minikube
```
minikube start
```

## Create minikube tunnel 
On other console run
```
minikube tunnel
```
And enter your password

## Install knative
```
./start_minikube.sh
```

## Build image on minikube
```
minikube image build -t dev.local/frontend:latest frontend
minikube image build -t dev.local/backend:latest backend
```

## Apply service
```
kubectl apply -f service.yaml
```

## Logs about service (just in case)
```
kubectl describe ksvc/backend
kubectl describe ksvc/frontend
```

## Get URL of service
```
kubectl get ksvc frontend -o jsonpath='{.status.url}'
kubectl get ksvc backend -o jsonpath='{.status.url}'
```