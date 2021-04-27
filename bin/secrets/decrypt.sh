#!/bin/bash

# decrypt enviroment variables
rm bin/.env
vault write sops/decrypt/firstkey ciphertext=$(cat bin/.env.enc) | grep "plaintext" | cut -d " " -f 5 | base64 --decode >> bin/.env
# decrypt ansible vault password
rm ansible/.vault_pass
vault write sops/decrypt/firstkey ciphertext=$(cat ansible/.vault_pass) | grep "plaintext" | cut -d " " -f 5 | base64 --decode >> ansible/.vault_pass