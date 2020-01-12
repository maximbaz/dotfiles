# ~/.dotfiles

![screenshot](https://user-images.githubusercontent.com/1177900/48734879-18572e80-ec47-11e8-938f-35be9b66d23a.png)

## Some of the worthy tools that I use, develop or help maintain:

- [i3-gaps](https://github.com/Airblader/i3) (window manager) + [py3status](https://github.com/ultrabug/py3status) (status bar)
- [kitty](https://github.com/kovidgoyal/kitty) (fast GPU-accelerated terminal)
- [kakoune](https://github.com/mawww/kakoune)
- [zsh](https://www.zsh.org) + [antigen](https://github.com/zsh-users/antigen) with [prezto](https://github.com/sorin-ionescu/prezto), [powerlevel10k](https://github.com/romkatv/powerlevel10k) and various other plugins
- [yubikey-touch-detector](https://github.com/maximbaz/yubikey-touch-detector) - a tool that can detect when your YubiKey is waiting for a touch.
- [browserpass](https://github.com/browserpass/browserpass-extension) - browser extension for `pass` and `gopass`.
- [wire-desktop](https://github.com/wireapp/wire-desktop) - end-to-end encrypted chat app.
- [ttf-joypixels](https://www.archlinux.org/packages/community/any/ttf-joypixels/) - latest JoyPixels font that provides colorful emojis for almost all apps on Linux (formerly EmojiOne).
- [chromium-vaapi](https://aur.archlinux.org/packages/chromium-vaapi) - chromium with hardware video acceleration.
- [nnn](https://github.com/jarun/nnn/) - extremely fast file manager.

## Fun things you can find in this repo:

☑ A common color scheme for kakoune, terminal and i3 itself.

> It is called [Gruvbox dark](https://github.com/morhetz/gruvbox).

☑ Unobtrusive and minimalistic design of i3, py3status and terminal.

> Display only actionable items, use color to highlight importance, slightly dim inactive windows.

☑ True Color support everywhere.

> Including kitty, kakoune; terminal can even display picture previews.

☑ Almost instant terminal startup.

> And yet it is empowered with antigen, prezto, powerlevel10k and other plugins.

☑ More secure gpg and ssh configuration.

> Stronger algorithms, more sensible defaults.

☑ gpg-agent configured to act as ssh-agent.

> Extremely nicely integrated with YubiKey, with forwarding to selected remote hosts.

☑ i3 automatically renames workspaces to show currently opened apps.

> Using iconic font to fit a lot of info even on laptop screens.

☑ Automatically change terminal's background color based on the ssh host.

> Terminal turns red when you are on production, yellow on staging, etc.

☑ Remember brightness levels on battery and on AC, restore last value when power source changes.

> Useful for automatically dimming screen when switching to battery power.

☑ Automatically connect to VPN on selected networks.

> Comes bundled with a script to prevent DNS leaks on NetworkManager.

☑ Automatically backup the list of installed packages (pacman and AUR).

> These files are used to bootstrap the new system, all apps are installed in one command.

☑ Setup script that configures user and system dotfiles, systemd services and other little things.

> This script is safe to re-run at any time.

☑ Arch Linux installation script.

> Fully automated script that installs Arch Linux from scratch and configures it exactly as I like.

## Usage:

```
$ git clone https://github.com/maximbaz/dotfiles.git ~/.dotfiles
$ ~/.dotfiles/setup-system.sh
$ ~/.dotfiles/setup-user.sh
```
