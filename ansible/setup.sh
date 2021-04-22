#!/bin/bash
parent_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
cd "$parent_path"

# Initiate fresh installs
ansible-playbook -i hosts plays/play-sys-init.yml
# Create necessary users
ansible-playbook -i hosts plays/play-sys-users.yml
# Setup loafbalancer for high aviabilty with keepalive and haproxy
ansible-playbook -i hosts plays/play-loadbalancer.yml --private-key=../.ssh/id_rsa_loadbalancer
# Setup etcd database cluster
ansible-playbook -i hosts plays/play-database.yml --private-key=../.ssh/id_rsa_etcd
# Setup servers (master nodes)
ansible-playbook -i hosts plays/play-k3s-server.yml --private-key=../.ssh/id_rsa_kube
# Setup agensts (slave nodes)
ansible-playbook -i hosts plays/play-k3s-agent.yml --private-key=../.ssh/id_rsa_kube