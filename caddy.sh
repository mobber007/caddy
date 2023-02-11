apt install -y debian-keyring debian-archive-keyring apt-transport-https
curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/gpg.key' | gpg --dearmor -o /usr/share/keyrings/caddy-stable-archive-keyring.gpg
curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/debian.deb.txt' | tee /etc/apt/sources.list.d/caddy-stable.list
apt update -y
apt install -y caddy jq curl wget zip unzip
caddy stop
caddy start
curl -s https://raw.githubusercontent.com/mobber007/caddy/main/caddy.json -o caddy.json
curl localhost:2019/load -H "Content-Type: application/json" -d @caddy.json
caddy reload