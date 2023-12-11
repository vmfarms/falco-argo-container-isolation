helm repo add falcosecurity https://falcosecurity.github.io/charts
helm repo update

echo "Creating Falco namespace"
kubectl create ns "falco"

helm repo
echo "Deploying Falco, Event Generator and Falco Exporter"
helm upgrade --install falco falcosecurity/falco --namespace falco --create-namespace -f default-values-falco.yaml
# helm install event-generator falcosecurity/event-generator --namespace falco
# helm install falco-exporter falcosecurity/falco-exporter -n falco
