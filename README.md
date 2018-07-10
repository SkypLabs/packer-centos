# Packer CentOS

This repository contains files used by [Packer][packer] to create CentOS images for different hypervisors.

## Hypervisors supported

* VirtualBox (`vbox`)
* VMware (`vmware`)
* KVM (`kvm`)

## Vagrant support

In order to create an image to be used with [Vagrant][vagrant], you need to use one of these builders:

* `vbox4vagrant`
* `vmware4vagrant`
* `kvm4vagrant`

## Variables available

    Optional variables and their defaults:

      build_number      = {{timestamp}}
      centos_arch       = x86_64
      disk_size         = 10000
      headless          = true
      iso_base_url      = http://ftp.heanet.ie/pub/centos
      iso_checksum_type = sha256
      password          = password
      timeout           = 30m
      username          = root

In addition, several variable files are available in order to precise which version of CentOS you want to use. The Packer `-var-file` option has to be used with one of these files.

## Use this template behind a proxy

In order to use this template behind an *explicit proxy*, you need to add this last one in some files:

* In the kickstart file:

        url --mirrorlist="http://mirrorlist.centos.org/?release=$releasever&arch=$basearch&repo=os" --proxy=<explicit proxy>

* In the `*-tools.sh` scripts, you need to add an option to the `yum` command:

        # Install dependencies
        yum --setopt=proxy=<explicit proxy> install -y ...

* In the `vagrant.sh` script, before the `curl` command:

        # Download the insecure public key from GitHub official repository
        export https_proxy=<explicit proxy>
        curl \
            --location \
            --output /home/vagrant/.ssh/authorized_keys \
            https://github.com/mitchellh/vagrant/raw/master/keys/vagrant.pub

## Examples

To create an image of CentOS 7 with all the hypervisors, including Vagrant images:

    packer build -var-file centos7.json packer-centos.json

To create an image of CentOS 6 with all the hypervisors, including Vagrant images:

    packer build -var-file centos6.json packer-centos.json

To create a Vagrant CentOS 7 image only with VirtualBox and overwrite some default variable's values (here, `headless` and `timeout`):

    packer build -only vbox4vagrant -var 'headless=false' -var 'timeout=1h' -var-file centos7.json packer-centos.json

## License

[MIT][license]

 [packer]: https://packer.io/
 [vagrant]: https://www.vagrantup.com/
 [license]: http://opensource.org/licenses/MIT
