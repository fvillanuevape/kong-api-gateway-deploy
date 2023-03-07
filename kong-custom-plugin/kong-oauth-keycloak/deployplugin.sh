kubectl create configmap kong-plugin-oauthbga --from-file=src -n kong

# Test
kubectl apply -f plugin-oauthbga.yaml