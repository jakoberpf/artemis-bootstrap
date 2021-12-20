# Bootstrapping multiple Raspberry Pi 4's [arm64] into a kubernetes cluster

Requirement:

- vault
- vault2env
- ansible

**Note** The setup script will install the correct ansible version for you.

## Setup boot disks

After flashing the image, re-mount the drive and copy the following files into `<drive>/system-boot/`:

- `user-data`
- `network-config`
- `cmdline.txt`

This can be streamlined with the following script: `bootstrap.sh`:

```bash
./bootstrap.sh kube-master|kube-worker-XX /Volumes/system-boot
```

## Setup raspberry pi`s

**TODO** Setup init ansible scripts
<https://help.ubuntu.com/community/InstallingANewHardDrive>

## Setup the kubernetes cluster

```bash
./kubespray/run.sh
```
