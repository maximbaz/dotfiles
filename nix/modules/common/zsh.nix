{ config, pkgs, ... }: {
  programs.zsh.enable = true;

  home-manager.users.${config.user}.home.file = {
    ".p10k-ascii-8color.zsh".source = ./zsh/.p10k.zsh;
    ".p10k.zsh".source = ./zsh/.p10k.zsh;
    ".zprofile".source = ./zsh/.zprofile;
    ".zsh-aliases".source = ./zsh/.zsh-aliases;
    ".zshenv".source = ./zsh/.zshenv;
    ".zshrc".source = ./zsh/.zshrc;
    ".zsh-platform".text =
      if pkgs.stdenv.isDarwin then ''
        export GPG_TTY="$TTY"
        export SSH_AUTH_SOCK="$HOME/.gnupg/S.gpg-agent.ssh"
        launchctl setenv GPG_TTY "$GPG_TTY"
        launchctl setenv SSH_AUTH_SOCK "$SSH_AUTH_SOCK"
      '' else "";
  };
}
