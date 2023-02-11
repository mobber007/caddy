sftp_group="box"
ssh_config_file="/etc/ssh/sshd_config"

sed -i "/Subsystem/c\Subsystem sftp internal-sftp" $ssh_config_file

if ! grep -q "Match Group $sftp_group" $ssh_config_file
then
    cat <<EOT >> $ssh_config_file
Match Group $sftp_group
ChrootDirectory /home/%u/$sftp_group
ForceCommand internal-sftp
PasswordAuthentication yes
PermitTunnel no
AllowAgentForwarding no
AllowTcpForwarding no
X11Forwarding no
EOT

fi

if ! grep -q $sftp_group "/etc/group"
then
    addgroup $sftp_group
fi
service ssh restart