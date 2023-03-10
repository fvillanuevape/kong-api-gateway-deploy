# Create Configmap
kubectl create configmap kong-plugin-bga-token-instrospection --from-file=src -n kong
kubectl apply -f plugin-custom-bga-oauth.yaml