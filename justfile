default: switch

[linux]
switch flags="":
    git -C $HOME/.dotfiles add --intent-to-add --all
    sudo nixos-rebuild switch --flake $HOME/.dotfiles --impure {{flags}}

[macos]
switch flags="":
    git -C $HOME/.dotfiles add --intent-to-add --all
    nix run -- nix-darwin switch --flake $HOME/.dotfiles {{flags}}

trace: (switch "--show-trace")
    
home:
    nix run -- home-manager switch --flake "$HOME/.dotfiles#$HOST"

update:
    nix flake update

update-private:
    git -C $HOME/.dotfiles-private add --intent-to-add --all
    nix flake lock --update-input maximbaz-private
