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
  config.vm.synced_folder "code/", "/code/", 
    create: true, 
    owner: "vagrant", 
    group: "vagrant",
    mount_options: ["dmode=777,fmode=777"]

  # Mount the dev_config/ folder we use to store stuff
  # we need to provision the machine.
  config.vm.synced_folder "dev_config/", "/dev_config/"

  # Mount the Docker certs.d folder.
  config.vm.synced_folder "docker_certs/", "/etc/docker/certs.d/", create: true

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

  # Provider-specific configuration.
  config.vm.provider :virtualbox do |vm|

    # Hack (?) required to get symlinks to work in VirtualBox shared folders.
    vm.customize ["setextradata", :id, "VBoxInternal2/SharedFoldersEnableSymlinksCreate/vagrant", "1"]
    vm.customize ["setextradata", :id, "VBoxInternal2/SharedFoldersEnableSymlinksCreate/home_vagrant_code_", "1"]

    # The amount of RAM given to the VM (in MB).
    vm.memory = "4096"

  end
end
