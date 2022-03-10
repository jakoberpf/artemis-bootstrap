version: 2
ethernets:
  eth0:
    addresses:
      - ${ip}/16
    gateway4: 192.168.178.1
    nameservers:
      addresses:
        - 1.1.1.1
        - 8.8.8.8
    dhcp4: no
    dhcp6: no
