# ~/.dotfiles

![screenshot](https://user-images.githubusercontent.com/1177900/33524775-24237df6-d823-11e7-88d0-2f28b0de3b41.png)

## Some of the worthy tools that I use:

- [i3-gaps](https://github.com/Airblader/i3) (window manager) + [py3status](https://github.com/ultrabug/py3status) (status bar)
- [kitty](https://github.com/kovidgoyal/kitty) (fast GPU-accelerated terminal)
- [neovim](https://github.com/neovim/neovim)
- [zsh](https://www.zsh.org) + [antigen](https://github.com/zsh-users/antigen) with [prezto](https://github.com/sorin-ionescu/prezto) and various other plugins

## Fun things you can find in this repo:

☑ A common color scheme for nvim, terminal and i3 itself.

> It is called [Gruvbox dark](https://github.com/morhetz/gruvbox).

☑ Unobtrusive and minimalistic design of i3, py3status and terminal.

> Display only actionable items, use color to highlight importance, slightly dim inactive windows.

☑ True Color support everywhere.

> Including kitty, neovim, tmux; ranger can even display picture previews.

☑ Almost instant terminal startup.

> And yet it is empowered with tmux, antigen, prezto and other plugins.

☑ Automatically start tmux in every terminal window:

- On local host, every terminal starts in its own tmux session.
  > This allows running multiple independent tmux windows in every terminal window.
- On remote host, every connection joins the same single tmux session
  > This makes it easy to reconnect after a network failure, your work stays as you left it.
- Speed-up terminal startup by ensuring that there always is an alive tmux session.
  > It takes tmux much longer to start the first session than to start every consequent one.

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
