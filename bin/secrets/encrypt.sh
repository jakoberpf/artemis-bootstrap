#!/bin/bash
# move to script folder
parent_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
cd "$parent_path"

vault write sops/encrypt/firstkey plaintext=$(base64 <<< $(cat .envrc)) | grep "ciphertext" | cut -d " " -f 6 | >> .envrc.enc

vault write sops/encrypt/firstkey plaintext=$(base64 <<< "Test") | grep "ciphertext" | cut -d " " -f 6 | >> .envrc.enc