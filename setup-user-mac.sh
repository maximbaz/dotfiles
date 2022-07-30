#!/bin/bash

set -e
exec 2> >(while read line; do echo -e "\e[01;31m$line\e[0m"; done)

MY_PGP_KEY_ID="12C87A28FEAC6B20"

dotfiles_dir="$(
    cd "$(dirname "$0")"
    pwd
)"
cd "$dotfiles_dir"

link() {
    orig_file="$dotfiles_dir/$1"
    if [ -n "$2" ]; then
        dest_file="$HOME/$2"
    else
        dest_file="$HOME/$1"
    fi

    mkdir -p "$(dirname "$orig_file")"
    mkdir -p "$(dirname "$dest_file")"

    rm -rf "$dest_file"
    ln -s "$orig_file" "$dest_file"
    echo "$dest_file -> $orig_file"
}

echo "==========================="
echo "Setting up user dotfiles..."
echo "==========================="

hostname="work"

link ".gnupg/$hostname-gpg.conf" ".gnupg/gpg.conf"
link ".gnupg/gpg-agent.conf"
link ".ignore"
link ".p10k.zsh"
link ".p10k.zsh" ".p10k-ascii-8color.zsh"
link ".zprofile"
link ".zsh-aliases"
link ".zshenv"
link ".zshrc"

link ".config/bat"
link ".config/chromium-flags.conf"
link ".config/git/$hostname" ".config/git/config"
link ".config/git/common"
link ".config/git/home"
link ".config/git/ignore"
link ".config/git/work"
link ".config/htop"
link ".config/kak"
link ".config/kak-lsp"
link ".config/kitty"
link ".config/mpv"
link ".config/pgcli/config"
link ".config/pylint"
link ".config/qutebrowser" ".qutebrowser"
link ".config/stylua"
link ".config/tig"
link ".config/xplr"

link ".config/nixpkgs"

link ".local/bin"
link ".local/share/qutebrowser/greasemonkey"

echo ""
echo "======================================="
echo "Finishing various user configuration..."
echo "======================================="

if ! gpg -k | grep "$MY_PGP_KEY_ID" > /dev/null; then
    echo "Importing my public PGP key"
    curl -s https://maximbaz.com/pgp_keys.asc | gpg --import
    echo "5\ny\n" | gpg --command-fd 0 --no-tty --batch --edit-key "$MY_PGP_KEY_ID" trust
fi

find "$HOME/.gnupg" -type f -not -path "*#*" -exec chmod 600 {} \;
find "$HOME/.gnupg" -type d -exec chmod 700 {} \;

if [ -d "$HOME/.password-store" ]; then
    echo "Configuring automatic git push for pass"
    echo -e "#!/bin/sh\n\npass git push" > "$HOME/.password-store/.git/hooks/post-commit"
    chmod +x "$HOME/.password-store/.git/hooks/post-commit"
else
    echo >&2 "=== Password store is not configured yet, skipping..."
fi

echo "Configure repo-local git settings"
git config user.email "git@maximbaz.com"
git config user.signingkey "04D7A219B0ABE4C2B62A5E654A2B758631E1FD91"
git config commit.gpgsign true
git remote set-url origin "git@github.com:maximbaz/dotfiles.git"

echo "==========================="
echo "Installing GUI apps..."
echo "==========================="

brew install gnupg pinentry-mac
brew install --cask \
    luesnooze \
    chromium \
    dmenu-mac \
    font-fontawesome \
    qutebrowser \
    browserosaurus \
    citrix-workspace \
    docker \
    kitty \
    teamviewer \
    caffeine \
    clipy \
    flameshot \
    meld \
    zoom
