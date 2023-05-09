

KIND=${PWD}/kind
SCRIPTS=${PWD}/scripts
CONSUMER=${PWD}/consumer

.PHONY: startup
startup:
	echo 'Creating cluster ...'
	@cd ${KIND} && kind create cluster --config config.yaml

.PHONY: metrics
metrics:
	@cd ${KIND}  && kubectl apply -f metric-server.yaml

.PHONY: workload-create
workload-create:
	@cd ${CONSUMER} && kubectl apply -f consumer-cpu.yml
	kubectl get pods

.PHONY: info
info:
	 cd ${SCRIPTS} && sh commands info

.PHONY: vpa-setup
vpa-setup:
	@cd ${SCRIPTS} && sh commands vpa

.PHONY: goldilocks
goldilocks:
	@cd ${SCRIPTS} && sh commands goldilocks

.PHONY: clean
clean:
	@echo 'Deleting cluster...'
	kind delete cluster 