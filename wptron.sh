sftp_user="${1//./}"
sftp_password="$(tr -dc A-Za-z0-9 </dev/urandom | head -c 13 ; echo '')"
echo $sftp_password > "$sftp_user.log"
sftp_group="sudo"
home_dir="/home/$sftp_user"
static_dir="/var/www/static/"
wp_dir="/var/www/wp/"
mkdir -p $static_dir
cp index.html $static_dir/index.html
mkdir -p $wp_dir
chown -R www-data:www-data /var/www
useradd $sftp_user
mkdir -p $home_dir
echo -e "$sftp_password\n$sftp_password" | passwd $sftp_user
adduser $sftp_user $sftp_group
chown -R $sftp_user:$sftp_user $home_dir


