 helm repo add kong https://charts.konghq.com
 helm repo update


# Helm 3
 kubectl create namespace kong
 helm install kong kong/kong -n kong

 
HOST=$(kubectl get svc --namespace kong kong-kong-proxy -o jsonpath='{.status.loadBalancer.ingress[0].ip}')
PORT=$(kubectl get svc --namespace kong kong-kong-proxy -o jsonpath='{.spec.ports[0].port}')
export PROXY_IP=${HOST}:${PORT}
curl $PROXY_IP

# Obtener default value
helm show values kong/kong > values-default.yaml

# Update Kong API Gateway with helm from file values.yaml
helm upgrade kong kong/kong -n kong -f values.yaml

# Update Kong API Gateway with helm from file values.yaml
helm upgrade kong kong/kong -n kong -f valuesdev.yaml


# Helm list chart kong
helm list  -n kong

# Helm release history
helm history -n kong kong

