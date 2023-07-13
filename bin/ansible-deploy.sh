#!/usr/bin/env bash
GIT_ROOT=$(git rev-parse --show-toplevel)
cd $GIT_ROOT || exit

# Run ansible playbook
sudo docker run --rm -it \
  --mount type=bind,source="$GIT_ROOT",target=/bootstrap \
  "$(sudo docker build -q .)" \
  bash -c "cd ansible && ansible-playbook ./site.yml -i ./inventory/artemis/hosts.ini"
