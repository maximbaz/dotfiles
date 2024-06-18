{
  home.file = {
    ".p10k-ascii-8color.zsh".text = builtins.readFile ./zsh/.p10k.zsh;
    ".p10k.zsh".text = builtins.readFile ./zsh/.p10k.zsh;
    ".zprofile".text = builtins.readFile ./zsh/.zprofile;
    ".zsh-aliases".text = builtins.readFile ./zsh/.zsh-aliases;
    ".zshenv".text = builtins.readFile ./zsh/.zshenv;
    ".zshrc".text = builtins.readFile ./zsh/.zshrc;
  };
}
