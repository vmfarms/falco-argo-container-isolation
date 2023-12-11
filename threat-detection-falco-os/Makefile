.PHONY: destroy install create-namespaces-if-not-exist deploy-argo delete-argo deploy-falco deps

install: deps deploy-rules deploy-falco deploy-argo
	@echo "Installation complete."

destroy: delete-argo delete-falco delete-rules
	@echo "Destroy complete."

create-namespaces-if-not-exist:
	kubectl create namespace argo || true
	kubectl create namespace falco || true

deps: create-namespaces-if-not-exist
	helm repo add falcosecurity https://falcosecurity.github.io/charts
	helm repo add argo https://argoproj.github.io/argo-helm
	helm repo update

deploy-argo:

	helm upgrade --install argo-workflows argo/argo-workflows --create-namespace --namespace argo --version 0.39.3 -f values/default-values-argo-workflow.yaml

	helm upgrade --install argo-events argo/argo-events --create-namespace --namespace argo-events --version 2.4.1 -f values/default-values-argo-events.yaml
	
	# kubectl apply -n argo-events -f https://raw.githubusercontent.com/argoproj/argo-events/stable/manifests/install.yaml
	# kubectl apply -n argo-events -f https://raw.githubusercontent.com/argoproj/argo-events/stable/manifests/install-validating-webhook.yaml
	# kubectl apply -n argo-events -f https://raw.githubusercontent.com/argoproj/argo-events/stable/examples/eventbus/native.yaml

	# kubectl apply -n argo -f https://github.com/argoproj/argo-workflows/releases/download/v3.4.13/install.yaml
	kubectl apply -f argo/

delete-argo:
	kubectl delete -f argo/ --wait=true || true

	helm uninstall --namespace argo argo-workflows --wait || true
	helm uninstall --namespace argo-events argo-events --wait || true
	
deploy-falco:
	helm upgrade --install falco falcosecurity/falco --namespace falco --create-namespace -f default-values-falco.yaml

delete-falco:
	helm uninstall --namespace falco falco --wait

deploy-rules:
	kubectl apply -n falco -f rules/rules-configmap.yaml

delete-rules:
	kubectl delete -n falco -f rules/rules-configmap.yaml