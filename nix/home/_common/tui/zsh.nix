{
  programs.zsh = {
    enable = true;

    envExtra = builtins.readFile ./zsh/.zshenv;
    profileExtra = builtins.readFile ./zsh/.zprofile;

    initExtraFirst = ''
      ${builtins.readFile ./zsh/.zshrc}
      ${builtins.readFile ./zsh/.zsh-aliases}
    '';
  };
}
