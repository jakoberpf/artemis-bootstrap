#!/usr/bin/env bash
GIT_ROOT=$(git rev-parse --show-toplevel)
cd $GIT_ROOT

# Setup secrets
./vault.sh

# Run kubespray deployment
docker run --rm -it \
  --mount type=bind,source="$GIT_ROOT"/kubespray/inventory/artemis,dst=/inventory \
  --mount type=bind,source="$GIT_ROOT"/.ssh/automation,dst=/root/.ssh/id_rsa \
  quay.io/kubespray/kubespray:v2.17.0 bash -c "ansible-playbook -i /inventory/inventory.ini -b --private-key /root/.ssh/id_rsa cluster.yml"

# Push kubernetes admin config to vault
admin_conf="$(cat kubespray/inventory/artemis/artifacts/admin.conf | base64)"
vault kv put CICD/repo/artemis-bootstrap/live/kube-secret admin_conf=$admin_conf