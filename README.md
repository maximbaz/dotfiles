# ~/.dotfiles

![screenshot](https://user-images.githubusercontent.com/1177900/48734879-18572e80-ec47-11e8-938f-35be9b66d23a.png)

## Some of the worthy tools that I use:

- [i3-gaps](https://github.com/Airblader/i3) (window manager) + [py3status](https://github.com/ultrabug/py3status) (status bar)
- [kitty](https://github.com/kovidgoyal/kitty) (fast GPU-accelerated terminal)
- [kakoune](https://github.com/mawww/kakoune)
- [zsh](https://www.zsh.org) + [antigen](https://github.com/zsh-users/antigen) with [prezto](https://github.com/sorin-ionescu/prezto) and various other plugins

## Fun things you can find in this repo:

☑ A common color scheme for kakoune, terminal and i3 itself.

> It is called [Gruvbox dark](https://github.com/morhetz/gruvbox).

☑ Unobtrusive and minimalistic design of i3, py3status and terminal.

> Display only actionable items, use color to highlight importance, slightly dim inactive windows.

☑ True Color support everywhere.

> Including kitty, kakoune, tmux; ranger can even display picture previews.

☑ Almost instant terminal startup.

> And yet it is empowered with antigen, prezto and other plugins.

☑ Automatically start tmux on the remote hosts.

- Every connection joins the same single tmux session, allowing to easily reconnect after a network failure, your work stays as you left it.

☑ More secure gpg and ssh configuration.

> Stronger algorithms, more sensible defaults.

☑ gpg-agent configured to act as ssh-agent.

> Extremely nicely integrated with YubiKey, with forwarding to selected remote hosts.

☑ i3 automatically renames workspaces to show currently opened apps.

> Using iconic font to fit a lot of info even on laptop screens.

☑ Automatically renumber tmux sessions.

> Helps when terminals are being opened & closed a lot during the day.

☑ Automatically change terminal's background color based on the ssh host.

> Terminal turns red when you are on production, yellow on staging, etc.

☑ Remember brightness levels on battery and on AC, restore last value when power source changes.

> Useful for automatically dimming screen when switching to battery power.

☑ Automatically connect to VPN on selected networks.

> Comes bundled with a script to prevent DNS leaks on NetworkManager.

☑ Lazy sourcing scripts to speedup terminal startup.

> This is useful for rvm, source it the first time you use `rvm` command.

☑ Automatically backup the list of installed packages (pacman and AUR).

> These files are used to bootstrap the new system, all apps are installed in one command.

☑ Setup script that configures user and system dotfiles, systemd services and other little things.

> This script is safe to re-run at any time.

☑ Compete and very detailed installation instructions for Arch Linux.

> Step-by-step description of how I install Arch Linux from scratch.

## Installation:

```
$ git clone https://github.com/maximbaz/dotfiles.git ~/.dotfiles
$ ~/.dotfiles/setup
```

## Awesome AUR packages that I help maintaining:

- [chromium-vaapi](https://aur.archlinux.org/packages/chromium-vaapi) and [chromium-vaapi-bin](https://aur.archlinux.org/packages/chromium-vaapi-bin) - chromium with hardware video acceleration.
- [ttf-emojione](https://aur.archlinux.org/packages/ttf-emojione) - latest EmojiOne font that provides colorful emojis for almost all apps on Linux.
- [yubikey-touch-detector](https://aur.archlinux.org/packages/yubikey-touch-detector) - a tool that can detect when your YubiKey is waiting for a touch.
- [browserpass](https://aur.archlinux.org/packages/browserpass) - browser extension for pass and gopass.
- [wire-desktop](https://aur.archlinux.org/packages/wire-desktop) and [wire-desktop-beta](https://aur.archlinux.org/packages/wire-desktop-beta) - end-to-end encrypted chat app.
- [rmtrash](https://aur.archlinux.org/packages/rmtrash) - trash bin for CLI made compatible to GNUs rm and rmdir.
- [snap-pac-grub](https://aur.archlinux.org/packages/snap-pac-grub) - updates GRUB for grub-btrfs with snapshots made by snap-pac.
