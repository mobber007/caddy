sftp_user="${1//./}"
sftp_password="$(tr -dc A-Za-z0-9 </dev/urandom | head -c 13 ; echo '')"
echo $sftp_password > "$sftp_user.log"
sftp_group="sudo"
domain=default
home_dir="/home/$sftp_user"
box_dir="$home_dir/box"
public_dir="$box_dir/$domain/public"

useradd $sftp_user
mkdir -p $public_dir
echo -e "$sftp_password\n$sftp_password" | passwd $sftp_user
adduser $sftp_user $sftp_group
cp index.html $public_dir/index.html
chown -R $sftp_user:$sftp_user $box_dir
chmod 755 $box_dir
caddy file-server --root $public_dir --domain $domain
