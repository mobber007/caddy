ufw allow http
ufw allow https
ufw reload
bash sftp.sh
bash wptron.sh
bash caddy.sh  > /dev/null 2>&1