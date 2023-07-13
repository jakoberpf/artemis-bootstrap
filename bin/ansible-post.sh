#!/usr/bin/env bash
GIT_ROOT=$(git rev-parse --show-toplevel)
cd $GIT_ROOT || exit

cp $GIT_ROOT/.kubespray/inventory/artemis/artifacts/admin.conf $GIT_ROOT/kubespray/artifacts/admin.conf
cp $GIT_ROOT/.kubespray/inventory/artemis/credentials/kubeadm_certificate_key.creds $GIT_ROOT/kubespray/credentials/kubeadm_certificate_key.creds

# Refine kubernetes admin config
config_file="kubespray/artifacts/admin.conf"
yq -i '.clusters[0].cluster.server = "https://api.artemis.k8s.erpf.de:6443"' $config_file
yq -i '.clusters[0].name = "erpf-artemis-live"' $config_file
yq -i '.contexts[0].context.cluster = "erpf-artemis-live"' $config_file
yq -i '.contexts[0].context.user = "admin"' $config_file
yq -i '.contexts[0].name = "erpf-artemis-live"' $config_file
yq -i '.current-context = "erpf-artemis-live"' $config_file
yq -i '.users[0].name = "admin"' $config_file

# Upload config to vault
vault_admin_config_base64="$(cat $config_file | base64)"
vault kv put CICD/repo/artemis-bootstrap/live/kube-secret admin_conf=$vault_admin_config_base64 | grep "create_time"
