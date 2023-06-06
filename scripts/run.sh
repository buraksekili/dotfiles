# This script runs Tyk Operator locally based on k8s secret created for Tyk Operator.
#
#	./run.sh

auth=$(kubectl get secrets -n tyk-operator-system tyk-operator-conf --template={{.data.TYK_AUTH}} | base64 -d)
org=$(kubectl get secrets -n tyk-operator-system tyk-operator-conf --template={{.data.TYK_ORG}} | base64 -d)
url=$(kubectl get secrets -n tyk-operator-system tyk-operator-conf --template={{.data.TYK_URL}} | base64 -d)
mode=$(kubectl get secrets -n tyk-operator-system tyk-operator-conf --template={{.data.TYK_MODE}} | base64 -d)

if [[ $mode == "ce" ]]; then
	url=http://localhost:8080
fi

go build && TYK_MODE=$mode TYK_AUTH=$auth TYK_ORG=$org TYK_URL=$url ENABLE_WEBHOOKS=false ./tyk-operator
