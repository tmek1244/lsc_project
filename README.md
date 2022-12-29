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
minikube image build -t dev.local/app:latest app
```

## Apply service
```
kubectl apply -f service.yaml
```

## Logs about service (just in case)
```
kubectl describe ksvc/app
```

## Get URL of service
```
kubectl get ksvc app -o jsonpath='{.status.url}'
```