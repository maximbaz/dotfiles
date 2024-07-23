nixos:
    sudo nixos-rebuild switch --flake $HOME/.dotfiles --impure

darwin:
    nix run -- nix-darwin switch --flake $HOME/.dotfiles

home:
    nix run -- home-manager switch --flake "$HOME/.dotfiles#$HOST"
