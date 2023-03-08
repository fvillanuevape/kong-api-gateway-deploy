kubectl create configmap kong-plugin-mytoken --from-file=src -n kong
kubectl apply -f plugin-custom-myheader.yaml