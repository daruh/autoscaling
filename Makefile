

KIND=${PWD}/kind
SCRIPTS=${PWD}/scripts
CONSUMER=${PWD}/consumer

#Setup cluster
.PHONY: startup
startup:
	echo 'Creating cluster ...'
	@cd ${KIND} && kind create cluster --config config.yaml

#Install metric server
.PHONY: metrics
metrics:
	@cd ${KIND}  && kubectl apply -f metric-server.yaml

#Install consumer cpu pods
.PHONY: workload-create
workload-create:
	@cd ${CONSUMER} && kubectl apply -f consumer-cpu.yml
	kubectl get pods

#Setup entire vpa from source
.PHONY: vpa-setup
vpa-setup:
	@cd ${SCRIPTS} && sh commands vpa

#Downloads only vpa sources
.PHONY: vpa-download
vpa-download:
	@cd ${SCRIPTS} && sh commands vpadownload

#Install vpa (after sources downloaded)
.PHONY: vpa-install
vpa-install:
	@cd ${SCRIPTS} && sh commands vpainstall

#Install goldilocks
.PHONY: goldilocks
goldilocks:
	@cd ${SCRIPTS} && sh commands goldilocks

#Deletes cluster
.PHONY: clean
clean:
	@echo 'Deleting cluster...'
	kind delete cluster 