# Thanks to https://github.com/csantanapr/knative-minikube

export KNATIVE_VERSION="1.8.3"
kubectl apply -f https://github.com/knative/serving/releases/download/knative-v${KNATIVE_VERSION}/serving-crds.yaml
kubectl wait --for=condition=Established --all crd

kubectl apply -f https://github.com/knative/serving/releases/download/knative-v${KNATIVE_VERSION}/serving-core.yaml

kubectl wait pod --timeout=-1s --for=condition=Ready -l '!job-name' -n knative-serving > /dev/null

export KNATIVE_NET_KOURIER_VERSION="1.8.1"
kubectl apply -f https://github.com/knative/net-kourier/releases/download/knative-v${KNATIVE_NET_KOURIER_VERSION}/kourier.yaml
kubectl wait pod --timeout=-1s --for=condition=Ready -l '!job-name' -n kourier-system
kubectl wait pod --timeout=-1s --for=condition=Ready -l '!job-name' -n knative-serving

EXTERNAL_IP=$(kubectl -n kourier-system get service kourier -o jsonpath='{.status.loadBalancer.ingress[0].ip}')
echo EXTERNAL_IP=$EXTERNAL_IP

KNATIVE_DOMAIN="$EXTERNAL_IP.sslip.io"
echo KNATIVE_DOMAIN=$KNATIVE_DOMAIN

kubectl patch configmap -n knative-serving config-domain -p "{\"data\": {\"$KNATIVE_DOMAIN\": \"\"}}"

kubectl patch configmap/config-network \
  --namespace knative-serving \
  --type merge \
  --patch '{"data":{"ingress.class":"kourier.ingress.networking.knative.dev"}}'

# kubectl apply -f service.yaml
# kubectl get ksvc app -o jsonpath='{.status.url}'



# export KNATIVE_EVENTING_VERSION="1.8.0"

# kubectl apply --filename https://github.com/knative/eventing/releases/download/knative-v${KNATIVE_EVENTING_VERSION}/eventing-crds.yaml
# kubectl wait --for=condition=Established --all crd

# kubectl apply --filename https://github.com/knative/eventing/releases/download/knative-v${KNATIVE_EVENTING_VERSION}/eventing-core.yaml

# kubectl wait pod --timeout=-1s --for=condition=Ready -l '!job-name' -n knative-eventing

# kubectl apply --filename https://github.com/knative/eventing/releases/download/knative-v${KNATIVE_EVENTING_VERSION}/in-memory-channel.yaml

# kubectl wait pod --timeout=-1s --for=condition=Ready -l '!job-name' -n knative-eventing

# kubectl apply --filename https://github.com/knative/eventing/releases/download/knative-v${KNATIVE_EVENTING_VERSION}/mt-channel-broker.yaml

# kubectl wait pod --timeout=-1s --for=condition=Ready -l '!job-name' -n knative-eventing
