{
  home.file = {
    ".zprofile".text = builtins.readFile ./zsh/.zprofile;
    ".zsh-aliases".text = builtins.readFile ./zsh/.zsh-aliases;
    ".zshenv".text = builtins.readFile ./zsh/.zshenv;
    ".zshrc".text = builtins.readFile ./zsh/.zshrc;
  };
}
