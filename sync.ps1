# Ask Vagrant to dump the `ssh_config` if it doesn't exist
# TODO

# Run unison
.\.bin\unison.exe code/ ssh://default//home/vagrant/code/ -sshargs "-F ssh_config" -batch -perms 0 -dontchmod -links false -times -force newer -repeat watch