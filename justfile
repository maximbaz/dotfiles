nixos:
    sudo nixos-rebuild switch --flake $HOME/.dotfiles --impure

darwin:
    nix run -- nix-darwin switch --flake $HOME/.dotfiles
