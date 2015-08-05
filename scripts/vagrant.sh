# Add vagrant user
useradd vagrant

# Do not require a password with sudo
# for vagrant user
cat > /etc/sudoers.d/vagrant <<'EOF'
Defaults:vagrant !requiretty
Defaults:vagrant secure_path=/usr/local/bin:/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/sbin
vagrant ALL=(ALL) NOPASSWD: ALL
EOF

# Change permissions on vagrant configuration file for sudo
chmod 0440 /etc/sudoers.d/vagrant

# Add SSH directory for vagrant user
install -d -o vagrant -g vagrant -m 0700 /home/vagrant/.ssh

# Download the insecure public key from GitHub official repository
curl \
	--location \
	--output /home/vagrant/.ssh/authorized_keys \
	https://github.com/mitchellh/vagrant/raw/master/keys/vagrant.pub

# Change owner and group on SSH authorized keys file for vagrant user
chown vagrant:vagrant /home/vagrant/.ssh/authorized_keys

# Change password for root and vagrant users
echo 'root:vagrant' | chpasswd
echo 'vagrant:vagrant' | chpasswd
