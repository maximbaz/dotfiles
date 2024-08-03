default: switch

[linux]
switch flags="": git-add
    sudo nixos-rebuild switch --flake $HOME/.dotfiles --impure {{flags}}

[macos]
switch flags="": git-add
    nix run -- nix-darwin switch --flake $HOME/.dotfiles {{flags}}

trace: (switch "--show-trace")

home: git-add
    nix run -- home-manager switch --flake "$HOME/.dotfiles#$HOST"

update: git-add
    nix flake update

git-add:
    git -C $HOME/.dotfiles add --intent-to-add --all