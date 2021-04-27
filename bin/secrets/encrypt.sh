#!/bin/bash

# encrypt enviroment variables
rm bin/.env.enc
vault write sops/encrypt/firstkey plaintext=$(base64 <<< $(cat bin/.env)) | grep "ciphertext" | cut -d " " -f 6 | >> bin/.env.enc
# encrypt ansible vault password
rm ansible/.vault_pass.enc
vault write sops/encrypt/firstkey plaintext=$(base64 <<< $(cat ansible/.vault_pass)) | grep "ciphertext" | cut -d " " -f 6 | >> ansible/.vault_pass.enc