#!/usr/bin/env bash
GIT_ROOT=$(git rev-parse --show-toplevel)
cd $GIT_ROOT

# Run kubespray deployment
rm -rf .kubespray/inventory/*
mkdir -p .kubespray/inventory/artemis
cp -r kubespray/* .kubespray/inventory/artemis

# Source python tooling
source $GIT_ROOT/.venv/kubespray/bin/activate

cd .kubespray && ansible-playbook --become --become-user=root \
  -i $GIT_ROOT/.kubespray/inventory/artemis/inventory.ini -b \
  --private-key $GIT_ROOT/.ssh/automation cluster.yml
