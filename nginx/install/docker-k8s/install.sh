# Ingress internal
# Add the ingress-nginx repository
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx

kubectl create ns ingress-nginx

helm install nginx-ingress-01 ingress-nginx/ingress-nginx \
    -f values.yaml



helm install nginx-ingress-01 ingress-nginx/ingress-nginx \
    --version 4.8.3 \
    --namespace ingress-nginx  \
    -f values.yaml    

helm install nginx-ingress-01 ingress-nginx/ingress-nginx \
    --namespace ingress-nginx  \
    -f values.yaml   