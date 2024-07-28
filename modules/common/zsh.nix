{ config, ... }: {
  programs.zsh.enable = true;

  home-manager.users.${config.user}.home.file = {
    ".p10k-ascii-8color.zsh".source = ./zsh/.p10k.zsh;
    ".p10k.zsh".source = ./zsh/.p10k.zsh;
    ".zprofile".source = ./zsh/.zprofile;
    ".zsh-aliases".source = ./zsh/.zsh-aliases;
    ".zshenv".source = ./zsh/.zshenv;
    ".zshrc".source = ./zsh/.zshrc;
  };
}
