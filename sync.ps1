function Write-Sync-Output() {

    if ($args) {
        Write-Host $args -ForegroundColor Yellow
    } else {
        $input | Write-Host -ForegroundColor Yellow
    }

}

# Ask Vagrant to dump the `ssh_config` if it doesn't exist

if (![System.IO.File]::Exists("$PSScriptRoot\ssh_config")) {

    Write-Sync-Output "ssh_config not found, getting it from Vagrant..."
    vagrant ssh-config | Out-File "$PSScriptRoot\ssh_config" -Encoding utf8
    Write-Sync-Output "Done."

} else {

    Write-Sync-Output "ssh_config found."

}

# Run unison

# Unison seems to hang while copying files when run with `-repeat watch` on the initial sync, but not otherwise. I'm not sure if 
# the bug is with `-repeat watch` specifically or if this is just a manifestation of a deeper problem, but so far it seems to work 
# fine if I just run it twice to make sure it doesn't get the chance to hang. 

Write-Sync-Output "Ready to run Unison."

Write-Sync-Output "Running initial sync..."
.\.bin\unison.exe code/ ssh://default//home/vagrant/code/ -sshargs "-F ssh_config" -batch -perms 0 -dontchmod -links false -times -force newer
Write-Sync-Output "Initial sync complete."

Write-Sync-Output "Starting Unison with `-repeat watch`..."
.\.bin\unison.exe code/ ssh://default//home/vagrant/code/ -sshargs "-F ssh_config" -batch -perms 0 -dontchmod -links false -times -force newer -repeat watch