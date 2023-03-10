domain="$1"
sftp_user="${1//./}"
sftp_password="$(tr -dc A-Za-z0-9 </dev/urandom | head -c 13 ; echo '')"
echo $sftp_password > "$sftp_user.log"
sftp_group="box"
home_dir="/home/$sftp_user"
box_dir="$home_dir/box"
public_dir="$box_dir/$domain/public"

useradd $sftp_user
mkdir -p $public_dir
echo -e "$sftp_password\n$sftp_password" | passwd $sftp_user
chown -R $sftp_user:$sftp_user $home_dir
adduser $sftp_user $sftp_group
usermod -s /bin/false $sftp_user
chown root:root $home_dir
chown -R $sftp_user:$sftp_user $box_dir
chmod 755 $box_dir
sudo -u $sftp_user curl -s https://raw.githubusercontent.com/mobber007/caddy/main/index.html -o $public_dir/index.html
caddy file-server --root $public_dir --domain $domain
