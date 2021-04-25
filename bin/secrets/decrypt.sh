#!/bin/bash
# Move to script folder
parent_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
cd "$parent_path"

# Decrypt config
ENCODE=vault write sops/decrypt/firstkey ciphertext=$(cat .envrc.enc) \
echo $ENCODE | base64 --decode
