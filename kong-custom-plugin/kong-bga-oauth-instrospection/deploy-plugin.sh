# Create Configmap
kubectl create configmap kong-plugin-oauthinstrospection --from-file=src -n kong
kubectl apply -f plugin-custom-bga-oauth.yaml