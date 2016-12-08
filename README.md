# Packer CentOS

This repository contains files used by [Packer][1] to create CentOS images for different hypervisors.

## Hypervisors supported

* VirtualBox (vbox)
* VMware (vmware)
* KVM (kvm)

## Vagrant support

In order to create an image to be used by [Vagrant][2], you have to use one of these builders :

* vbox4vagrant
* vmware4vagrant
* kvm4vagrant

## Variables available

    Optional variables and their defaults:

      build_number      = {{timestamp}}
      centos_arch       = x86_64
      disk_size         = 10000
      headless          = true
      iso_base_url      = http://centos.mirrors.ovh.net/ftp.centos.org
      iso_checksum_type = sha256
      password          = password
      timeout           = 30m
      username          = root

In addition, several variables files are available in order to precise which version of CentOS you want to use. The Packer *-var-file* option has to be used with one of these files.

## Use this template behind a proxy

In order to use this template behind an *explicit proxy*, you have to add this last in some files :

* In the kickstart file :

        url --url="http://centos.mirrors.ovh.net/ftp.centos.org/7/os/x86_64/" --proxy=<explicit proxy>

* In the \*-tools.sh scripts, you have to add an option to the yum command :

        # Install dependencies
        yum --setopt=proxy=<explicit proxy> install -y ...

* In the vagrant.sh script, before the curl command :

        # Download the insecure public key from GitHub official repository
        export https_proxy=<explicit proxy>
        curl \
            --location \
            --output /home/vagrant/.ssh/authorized_keys \
            https://github.com/mitchellh/vagrant/raw/master/keys/vagrant.pub

## Examples

To create an image of CentOS 7 for all the hypervisors, including images with Vagrant support :

    packer build -var-file centos7.json packer-centos.json

To create an image of CentOS 6 for all the hypervisors, including images with Vagrant support :

    packer build -var-file centos6.json packer-centos.json

To create an CentOS 7 image only for VirtualBox with Vagrant support and some default variable values overwritten, for example, *headless* and *timeout* :

    packer build -only vbox4vagrant -var 'headless=false' -var 'timeout=1h' -var-file centos7.json packer-centos.json

## License

[MIT][3]

 [1]: https://packer.io/
 [2]: https://www.vagrantup.com/
 [3]: http://opensource.org/licenses/MIT
