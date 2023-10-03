# Bootstrapping a Raspberry Pi [arm64] kubernetes cluster
Requirement:

- vault
- kubespray

**and** some raspberries ;-)

TODO https://discuss.hashicorp.com/t/store-and-read-ssh-pvt-keys-from-the-vault/39414/12

scp -i .ssh/automation -o StrictHostKeyChecking=no ubuntu@192.168.1.11:~/.kube/config .config

https://technotim.live/posts/k3s-etcd-ansible/

https://docs.orbstack.dev/machines/

https://github.com/renovatebot/renovate/discussions/13845