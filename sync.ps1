# Ask Vagrant to dump the `ssh_config` if it doesn't exist

if (![System.IO.File]::Exists("$PSScriptRoot\ssh_config")) {

    Write-Output "ssh_config not found, getting it from Vagrant..."
    vagrant ssh-config | Out-File "$PSScriptRoot\ssh_config" -Encoding utf8
    Write-Output "Done."

} else {

    Write-Output "ssh_config found."

}

# Run unison

Write-Output "Running Unison."
.\.bin\unison.exe code/ ssh://default//home/vagrant/code/ -sshargs "-F ssh_config" -batch -perms 0 -dontchmod -links false -times -force newer -repeat watch