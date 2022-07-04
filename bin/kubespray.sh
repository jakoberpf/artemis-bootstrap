#!/usr/bin/env bash
GIT_ROOT=$(git rev-parse --show-toplevel)
cd $GIT_ROOT

# Setup secrets
./vault.sh

# Run kubespray deployment
docker run --rm -it \
  --mount type=bind,source="$GIT_ROOT"/kubespray,dst=/inventory \
  --mount type=bind,source="$GIT_ROOT"/.ssh/automation,dst=/root/.ssh/id_rsa \
  quay.io/kubespray/kubespray:v2.19.0 bash -c "ansible-playbook -i /inventory/inventory.ini -b --private-key /root/.ssh/id_rsa cluster.yml"

# Push kubernetes admin config to vault
config_file="kubespray/artifacts/admin.conf"
yq -i '.clusters[0].cluster.server = "https://api.artemis.k8s.erpf.de:6443"' $config_file
yq -i '.clusters[0].name = "erpf-artemis-live"' $config_file
yq -i '.contexts[0].context.cluster = "erpf-artemis-live"' $config_file
yq -i '.contexts[0].context.user = "admin"' $config_file
yq -i '.contexts[0].name = "erpf-artemis-live"' $config_file
yq -i '.current-context = "erpf-artemis-live"' $config_file
yq -i '.users[0].name = "admin"' $config_file
admin_conf="$(cat $config_file | base64)"
vault kv put CICD/repo/artemis-bootstrap/live/kube-secret admin_conf=$admin_conf
