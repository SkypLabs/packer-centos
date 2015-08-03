if [ "$VAGRANT" == "true" ]
then
	useradd vagrant

	cat > /etc/sudoers.d/vagrant <<'EOF'
Defaults:vagrant !requiretty
Defaults:vagrant secure_path=/usr/local/bin:/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/sbin
vagrant ALL=(ALL) NOPASSWD: ALL
EOF

	chmod 0440 /etc/sudoers.d/vagrant

	install -d -o vagrant -g vagrant -m 0700 /home/vagrant/.ssh

	curl \
		--location \
		--output /home/vagrant/.ssh/authorized_keys \
		https://github.com/mitchellh/vagrant/raw/master/keys/vagrant.pub

	chown vagrant:vagrant /home/vagrant/.ssh/authorized_keys

	echo 'root:vagrant' | chpasswd
	echo 'vagrant:vagrant' | chpasswd
fi
