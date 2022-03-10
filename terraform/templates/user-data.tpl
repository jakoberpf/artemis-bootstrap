#cloud-config

hostname: ${id}

chpasswd:
  expire: false
  list:
  - ${username}:${password}

# Enable password authentication with the SSH daemon
ssh_pwauth: false

ssh_authorized_keys:
  - ${authorized_keys}

## Update apt database and upgrade packages on first boot
package_update: true
package_upgrade: true

packages:
- curl
- wget
- htop

runcmd:
- ln -sfn /run/systemd/resolve/resolv.conf /etc/resolv.conf
- sync
- reboot -f
- sed -i '/^127\.0\.0\.1\s/s/$/ '"localhost ${id}"'/' /etc/hosts
- sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
