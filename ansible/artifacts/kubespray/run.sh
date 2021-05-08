docker pull quay.io/kubespray/kubespray:v2.15.1
docker run --rm -it --mount type=bind,source="$(pwd)"/inventory/sample,dst=/inventory \
  --mount type=bind,source="${HOME}"/.ssh/id_rsa,dst=/root/.ssh/id_rsa \
  quay.io/kubespray/kubespray:v2.15.1 bash
# Inside the container you may now run the kubespray playbooks:
eval $(ssh-agent -s)
ssh-add ~/.ssh/id_rsa
# ansible-playbook -i /inventory/inventory.ini -b --private-key /root/.ssh/id_rsa cluster.yml

https://github.com/kubernetes-sigs/kubespray/tree/master/contrib/terraform/openstack