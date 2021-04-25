#!/bin/bash
# move to script folder
parent_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
cd "$parent_path"

# encrypt enviroment variables
rm bin/.envrc.enc
vault write sops/encrypt/firstkey plaintext=$(base64 <<< $(cat bin/.envrc)) | grep "ciphertext" | cut -d " " -f 6 | >> bin/.envrc.enc
# encrypt ansible vault password
rm ansible/.vault_pass.enc
vault write sops/encrypt/firstkey plaintext=$(base64 <<< $(cat ansible/.vault_pass)) | grep "ciphertext" | cut -d " " -f 6 | >> ansible/.vault_pass.enc