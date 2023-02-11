apt install -y debian-keyring debian-archive-keyring apt-transport-https jq git curl wget zip unzip
curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/gpg.key' | gpg --dearmor -o /usr/share/keyrings/caddy-stable-archive-keyring.gpg
curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/debian.deb.txt' | tee /etc/apt/sources.list.d/caddy-stable.list
apt update -y
apt install -y caddy
public_ip="$(dig +short myip.opendns.com @resolver1.opendns.com)"
curl localhost:2019/load -H "Content-Type: application/json" -d @$public_ip.json