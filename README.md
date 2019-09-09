# dev

This is my personal Vagrant-based development setup. I mainly use it to have a \*nix-based dev environment on Windows, without having to deal with the "fun" parts of desktop Linux.

As I said above, this is my personal setup; you're absolutely free to take inspiration from it and/or steal chunks of it for your own config as much as you like, but I don't recommend using it as-is, since I don't imagine it's likely that you have the exact same name, projects, preferred stacks, and tooling preferences as me.

## Requirements

- [VirtualBox](https://www.virtualbox.org/)
- [Vagrant](https://www.vagrantup.com/)

If you're on Windows, make sure to disable Hyper-V first, or the VM won't boot. (You may need to reboot multiple times after disabling Hyper-V for it to actually have an effect; don't ask me how I know that.)

## Running

```
vagrant up
vagrant ssh
```

That's it. :)

See the [Vagrant docs](https://www.vagrantup.com/docs/index.html) for more stuff you can do.

## Notes

### Symlinks

To get symlinks to work on a Windows host, you'll need to follow these steps:

- Open Local Security Policy
- Go to Local Policies -> User Rights Assignment
- Open the entry "Create symbolic links" and add your user
- Reboot

This is necessary because, while Windows supports symlinks, creating them isn't something regular users can do by default (God knows why).

### Windows Defender

If you're on a Windows host, turning Windows Defender off, or at least whitelisting your `code/` folder, is strongly recommended for performance reasons. [This article](https://www.windowscentral.com/how-permanently-disable-windows-defender-windows-10) describes a few ways you can turn it off permanently.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE)
file for details.
