# This script runs Snapshot tool of Tyk Operator. It populates credentials based on Tyk Operator's
# currently connected Tyk installation, through reading the k8s secret created for Tyk Operator.
#
#	./snapshot.sh


auth=$(kubectl get secrets -n tyk-operator-system tyk-operator-conf --template={{.data.TYK_AUTH}} | base64 -d)
org=$(kubectl get secrets -n tyk-operator-system tyk-operator-conf --template={{.data.TYK_ORG}} | base64 -d)
url=$(kubectl get secrets -n tyk-operator-system tyk-operator-conf --template={{.data.TYK_URL}} | base64 -d)


mode=$(kubectl get secrets -n tyk-operator-system tyk-operator-conf --template={{.data.TYK_MODE}} | base64 -d)
if [[ $mode == "ce" ]]; then
	url=http://localhost:8080
fi

echo "mode: $mode"
echo "auth: $auth"
echo "org: $org"
echo "url: $url"

go build && TYK_MODE=$mode TYK_AUTH=$auth TYK_ORG=$org TYK_URL=$url ./tyk-operator --apidef=output.yaml


