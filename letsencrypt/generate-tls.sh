

sudo apt update
sudo apt-get install letsencrypt


sudo certbot certonly --manual \
--preferred-challenges=dns --email fvillanueva.pe@gmail.com \
--server https://acme-v02.api.letsencrypt.org/directory \
--agree-tos -d *.fvillanueva.com.pe
