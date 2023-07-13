#!/usr/bin/env bash
GIT_ROOT=$(git rev-parse --show-toplevel)
cd $GIT_ROOT

# Run ansible playbook
sudo docker run --rm -it \
  --mount type=bind,source="$GIT_ROOT",target=/bootstrap \
  $(sudo docker build -q .) \
  bash -c "cd ansible && ansible-playbook ./site.yml -i ./inventory/artemis/hosts.ini"

# Push kubernetes admin config to vault
# config_file=".config"
# yq -i '.clusters[0].cluster.server = "https://api.artemis.k8s.erpf.de:6443"' $config_file
# yq -i '.clusters[0].name = "erpf-artemis-live"' $config_file
# yq -i '.contexts[0].context.cluster = "erpf-artemis-live"' $config_file
# yq -i '.contexts[0].context.user = "admin"' $config_file
# yq -i '.contexts[0].name = "erpf-artemis-live"' $config_file
# yq -i '.current-context = "erpf-artemis-live"' $config_file
# yq -i '.users[0].name = "admin"' $config_file
# admin_conf="$(cat $config_file | base64)"
# vault kv put CICD/repo/artemis-bootstrap/live/kube-secret admin_conf=$admin_conf
