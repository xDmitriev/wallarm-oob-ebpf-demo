include .env

AP_HOST := ebpf-demo.com
TF_ARGS := -var wallarm_api_token=${WALLARM_API_TOKEN} -var wallarm_api_host=${WALLARM_API_HOST}
TF_DIR  := -chdir=$(CURDIR)/terraform
CLUSTER = $(shell terraform ${TF_DIR} output -raw cluster_name)
LB_IP   = $(shell kubectl get svc -l "app.kubernetes.io/component=controller" -n ingress-nginx -o=jsonpath='{.items[0].status.loadBalancer.ingress[0].ip}')

all: init apply get-config

init:
	cd ${CURDIR}/terraform && terraform init

apply:
	terraform ${TF_DIR} apply ${TF_ARGS} --auto-approve

get-config:
	az aks get-credentials --admin --name ${CLUSTER} -g ${CLUSTER}

attack-http:
	curl -H "Host: ${AP_HOST}" ${LB_IP}/anything/etc/passwd


attack-https:
	curl -k -H "Host: ${AP_HOST}" https://${LB_IP}/etc/passwd

# Step 6
destroy:
	terraform ${TF_DIR}  destroy ${TF_ARGS} --auto-approve
