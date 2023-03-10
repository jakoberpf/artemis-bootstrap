# node init guide

## partition and format

### partition
Partition with new table. 
```
fdisk /dev/sda
$ g (generate new table)
$ n (create new partition)
$ w (write out new partition table)
```
Verify changes on disk.
```
lsblk -f
```
### format
Format disk with preferred file format.
```
# mkfs [options] [-t type fs-options] device [size]
mkfs -t [ext4|ntfs|vfat] /dev/sda1
```
Verify changes on disk.
```
lsblk -f
```