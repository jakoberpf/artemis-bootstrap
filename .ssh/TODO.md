# Improvements
Keeping the SSH keys in git is not preferable. As a future improvement, the keys should be kept in a secret store like hashicorp vault. When the runner scripts are executed the SSH keys will be pulled from vault with the users credentials and therefore give a use based execution control.
