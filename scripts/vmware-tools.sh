#!/usr/bin/env bash

# Install dependencies
yum install -y perl

# Mount VMware Tools ISO file
mount -t iso9660 -o loop /root/linux.iso /mnt

# Execute the installer
cd /tmp
cp /mnt/VMwareTools-*.gz .
tar zxvf VMwareTools-*.gz
./vmware-tools-distrib/vmware-install.pl -d

# Unmount ISO file
umount /mnt

# Delete ISO file
rm -f /root/linux.iso

# Delete copied files from ISO
rm -rf VMwareTools-.gz vmware-tools-distrib
