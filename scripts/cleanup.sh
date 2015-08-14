#!/usr/bin/env bash

## See http://lonesysadmin.net/2013/03/26/preparing-linux-template-vms/
## for more informations

# Stop cron service
service crond stop

# Stop logging services
service rsyslog stop
service auditd stop

# Clean out yum
yum -y clean all

# Force the logs to rotate and remove old logs we don’t need
logrotate -f /etc/logrotate.conf
rm -f /var/log/*-???????? /var/log/*.gz
rm -f /var/log/dmesg.old
rm -rf /var/log/anaconda

# Truncate the audit logs
cat /dev/null > /var/log/audit/audit.log
cat /dev/null > /var/log/wtmp
cat /dev/null > /var/log/lastlog
cat /dev/null > /var/log/grubby

# Remove the udev persistent device rules
rm -f /etc/udev/rules.d/70*

# Remove the traces of the template MAC address and UUIDs
sed -i '/^(HWADDR|UUID)=/d' /etc/sysconfig/network-scripts/ifcfg-eth0

# Clean /tmp out
rm -rf /tmp/*
rm -rf /var/tmp/*

# Remove the SSH host keys
rm -f /etc/ssh/*key*

# Remove root user's SSH files
rm -rf ~root/.ssh/

# Remove the root user’s shell history
rm -f ~root/.bash_history
unset HISTFILE

# Remove installation logs
rm -f ~root/anaconda-ks.cfg
rm -f ~root/install.log*
