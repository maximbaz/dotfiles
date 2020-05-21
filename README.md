# ~/.dotfiles

![screenshot](https://user-images.githubusercontent.com/1177900/48734879-18572e80-ec47-11e8-938f-35be9b66d23a.png)

## Some of the worthy tools that I use, develop or help maintain:

- [sway](https://github.com/swaywm/sway) (window manager) + [waybar](https://github.com/Alexays/Waybar) (status bar)
- [kitty](https://github.com/kovidgoyal/kitty) (fast GPU-accelerated terminal)
- [kakoune](https://github.com/mawww/kakoune) (modular text editor with multiple cursors)
- [zsh](https://www.zsh.org) + [powerlevel10k](https://github.com/romkatv/powerlevel10k) and various other plugins
- [yubikey-touch-detector](https://github.com/maximbaz/yubikey-touch-detector) - a tool that can detect when your YubiKey is waiting for a touch.
- [browserpass](https://github.com/browserpass/browserpass-extension) - browser extension for `pass` and `gopass`.
- [wire-desktop](https://github.com/wireapp/wire-desktop) - end-to-end encrypted chat app.
- [wluma](https://github.com/maximbaz/wluma) - automatic brightness adjustment based on screen contents.
- [ttf-joypixels](https://www.archlinux.org/packages/community/any/ttf-joypixels/) - latest JoyPixels font that provides colorful emojis for almost all apps on Linux (formerly EmojiOne).
- [aurutils](https://github.com/AladW/aurutils) - the most reasonable AUR helper out there.
- [nnn](https://github.com/jarun/nnn/) - extremely fast file manager.
- [grub-btrfs](https://github.com/Antynea/grub-btrfs) + [snap-pac-grub](https://github.com/maximbaz/snap-pac-grub) - take btrfs snapshots during system update and add them to GRUB.

## Fun things you can find in this repo:

☑ A common color scheme for kakoune, terminal and sway itself.

> It is called [Gruvbox dark](https://github.com/morhetz/gruvbox).

☑ Unobtrusive and minimalistic design of sway, waybar and terminal.

> Display only actionable items, use color to highlight importance, slightly dim inactive windows.

☑ True Color support everywhere.

> Including kitty, kakoune; terminal can even display picture previews.

☑ Almost instant terminal startup.

> And yet it is empowered with antigen, prezto, powerlevel10k and other plugins.

☑ More secure gpg and ssh configuration.

> Stronger algorithms, more sensible defaults.

☑ gpg-agent configured to act as ssh-agent.

> Extremely nicely integrated with YubiKey, with forwarding to selected remote hosts.

☑ sway automatically renames workspaces to show currently opened apps.

> Using iconic font to fit a lot of info even on laptop screens.

☑ Automatically change terminal's background color based on the ssh host.

> Terminal turns red when you are on production, yellow on staging, etc.

☑ Automatically adjust brightness level based on screen contents and amount of ambient light around.

> Useful for working at night, e.g. by dimming screen when switching from a dark terminal to a bright browser.

☑ Automatically backup the list of installed packages (pacman and AUR).

> These files are used to bootstrap the new system, all apps are installed in one command.

☑ Setup script that configures user and system dotfiles, systemd services and other little things.

> This script is safe to re-run at any time.

☑ Arch Linux installation script.

> Fully automated script that installs Arch Linux from scratch and configures it exactly as I like.

☑ btrfs snapshots for easy system recovery.

> Snapshots are automatically taken before and after each pacman transaction and added to GRUB.

## Usage:

```
$ git clone https://github.com/maximbaz/dotfiles.git ~/.dotfiles
$ ~/.dotfiles/setup-system.sh
$ ~/.dotfiles/setup-user.sh
```

## System recovery

In case system doesn't boot:

1. Boot in a recent snapshot that works
1. Make it the default snapshot

   ```
   # cd /mnt/btrfs-root/
   # mv root root-bak
   # btrfs subvolume snapshot snapshots/NN/snapshot root
   ```

1. Reboot
