# Bootstrapping multiple Raspberry Pi 4's [arm64] into a kubernetes cluster

Requirement:

- vault
- vault2env
- talosctl
- talhelper


## Generate configuration

```bash
age-keygen
talhelper gensecret > talsecret.sops.yaml
sops -e -i talsecret.sops.yaml
talhelper genconfig
```

## Bootstrap control-plane-nodes

After flashing the `talos` image to the SD card, boot the first node and start bootstrapping.

```bash
talosctl apply-config --insecure --nodes 192.168.1.11 --file clusterconfig/artemis-master1.yaml
talosctl apply-config --insecure --nodes 192.168.1.12 --file clusterconfig/artemis-master2.yaml
talosctl apply-config --insecure --nodes 192.168.1.13 --file clusterconfig/artemis-master3.yaml
```

## Bootstrap worker-nodes

```bash
talosctl apply-config --insecure --nodes 192.168.1.14 --file clusterconfig/artemis-worker1.yaml
talosctl apply-config --insecure --nodes 192.168.1.15 --file clusterconfig/artemis-worker2.yaml
talosctl apply-config --insecure --nodes 192.168.1.16 --file clusterconfig/artemis-worker3.yaml
```

## Bootstrap cluster and retrieve cluster configuration

```bash
talosctl bootstrap --nodes 192.168.1.11 --talosconfig clusterconfig/talosconfig
# This could take several minutes
talosctl config endpoint --talosconfig clusterconfig/talosconfig 192.168.1.11
talosctl kubeconfig --talosconfig clusterconfig/talosconfig --force-context-name artemis --nodes 192.168.1.11
```

## Troubleshooting

```bash
talosctl disks --insecure --nodes 192.168.0.38
talosctl dmesg --nodes 192.168.1.11 --endpoints 192.168.1.11
```

## Resources

<https://www.talos.dev/v1.3/talos-guides/install/single-board-computers/rpi_4/>
<https://kubito.dev/posts/talos-linux-raspberry-pi/>
