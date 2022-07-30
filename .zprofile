#!/usr/bin/env zsh

for file in 10-locale 20-xdg 40-clean-home 50-progs; do
    while read -r line; do
        [ -n "$line" ] || continue
        export "$(eval echo "$line")"
        launchctl setenv $(eval echo "$line" | sed 's/=/ /')
    done <"$HOME/.dotfiles/.config/environment.d/$file.conf"
done

export GPG_TTY="$TTY"
launchctl setenv GPG_TTY "$TTY"

export SSH_AUTH_SOCK="$HOME/.gnupg/S.gpg-agent.ssh"
launchctl setenv SSH_AUTH_SOCK "$HOME/.gnupg/S.gpg-agent.ssh"

# sudo launchctl config user path '/Users/maximbaz/.local/bin:/Users/maximbaz/.local/bin-private:/Users/maximbaz/.nix-profile/bin:/nix/var/nix/profiles/default/bin:/opt/homebrew/bin:/opt/homebrew/sbin:/usr/local/bin:/Applications/kitty.app/Contents/MacOS:/usr/bin:/bin:/usr/sbin:/sbin:/Users/maximbaz/.local/state/go/bin'
