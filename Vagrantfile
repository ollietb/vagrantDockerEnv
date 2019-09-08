# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  # The base image is `ubuntu/bionic64`, i.e. Ubuntu 18.04 LTS.
  config.vm.box = "ubuntu/bionic64"

  # Install Docker.
  config.vm.provision "docker"

  # Run the bootstrap script.
  config.vm.provision :shell, path: "bootstrap.sh"

  # Set the guest hostname.
  config.vm.hostname = "dev"

  # Mount the code/ folder onto the guest.
  # It'll be created on the host if it doesn't exist.
  config.vm.synced_folder "code/", "/home/vagrant/code/", 
    create: true, 
    owner: "vagrant", 
    group: "vagrant",
    mount_options: ["uid=1000,gid=1000,dmode=775,fmode=775"]

  # Forward ports.

  config.vm.network "forwarded_port", guest: 3000, host: 3000
  config.vm.network "forwarded_port", guest: 8000, host: 8000
  config.vm.network "forwarded_port", guest: 20000, host: 20000
  config.vm.network "forwarded_port", guest: 21000, host: 21000

  for i in 8080..8090
    config.vm.network :forwarded_port, guest: i, host: i
  end

  for i in 38000..38050
    config.vm.network :forwarded_port, guest: i, host: i
  end

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network "private_network", ip: "192.168.33.10"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  # config.vm.provider "virtualbox" do |vb|
  #   # Display the VirtualBox GUI when booting the machine
  #   vb.gui = true
  #
  #   # Customize the amount of memory on the VM:
  #   vb.memory = "1024"
  # end
  #
  # View the documentation for the provider you are using for more
  # information on available options.
end
