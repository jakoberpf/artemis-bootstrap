#!/usr/bin/env bash
GIT_ROOT=$(git rev-parse --show-toplevel)
cd $GIT_ROOT

sops --decrypt --input-type yaml --output-type yaml kubespray/kubespray.yaml.enc > kubespray/kubespray.yaml