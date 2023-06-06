# This script parses your Tyk installation k8s secret and creates
# identical k8s secret in `tyk-operator-system` namespace.
#
# FLAGS:
#
# ce (optional):
# 	By default, the script looks Tyk Pro k8s secret. If you want to use Tyk CE,
# 	please specify 'ce' as follows:
#		./scripts/copy.sh ce
#
# svc (optional):
# 	By default, the script creates URL based on locally forwarded port. 
# 	If you deployed your Tyk Operator in your cluster, please use service address
# 	and specify 'svc' flag as follows:
#		./scripts/copy.sh svc
#
#	NOTE: You can also combine 'svc' flag with 'ce' BUT please first specify
#		'ce' flag then 'svc', as follows:
#		./scripts/copy.sh ce svc


ns="tykpro-control-plane"

if [[ $1 == "ce" ]]; then
	url=http://localhost:8080
	if [[ $2 == "svc" ]]; then
		url=http://gateway-svc-ce-tyk-headless.tykce-control-plane.svc.cluster.local:8080
	fi

	echo "TYK_AUTH:	foo"
	echo "TYK_ORG:	myorg"
	echo "TYK_URL:	$url"
	echo "TYK_MODE:	ce"

	kubectl delete secret -n tyk-operator-system tyk-operator-conf
	kubectl create secret -n tyk-operator-system generic tyk-operator-conf \
		--from-literal "TYK_AUTH=foo" \
		--from-literal "TYK_ORG=myorg" \
		--from-literal "TYK_URL=$url" \
		--from-literal "TYK_TLS_INSECURE_SKIP_VERIFY=true" \
		--from-literal "TYK_MODE=ce"
	exit 0
fi

url=http://localhost:3000
if [[ $1 == "svc" ]]; then
	url=$(kubectl get secrets -n tykpro-control-plane tyk-operator-conf --template={{.data.TYK_URL}} | base64 -d)
fi

auth=$(kubectl get secrets -n tykpro-control-plane tyk-operator-conf --template={{.data.TYK_AUTH}} | base64 -d)
org=$(kubectl get secrets -n tykpro-control-plane tyk-operator-conf --template={{.data.TYK_ORG}} | base64 -d)
mode=$(kubectl get secrets -n tykpro-control-plane tyk-operator-conf --template={{.data.TYK_MODE}} | base64 -d)

echo "TYK_AUTH:	$auth"
echo "TYK_ORG:	$org"
echo "TYK_URL:	$url"
echo "TYK_MODE:	$mode"

kubectl delete secret -n tyk-operator-system tyk-operator-conf

kubectl create secret -n tyk-operator-system generic tyk-operator-conf \
--from-literal "TYK_AUTH=$auth" \
--from-literal "TYK_ORG=$org" \
--from-literal "TYK_URL=$url" \
--from-literal "TYK_TLS_INSECURE_SKIP_VERIFY=true" \
--from-literal "TYK_MODE=$mode"
