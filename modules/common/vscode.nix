{ config, pkgs, ... }: {
  home-manager.users.${config.user}.programs.vscode = {
    enable = true;
    enableUpdateCheck = false;

    extensions = with pkgs.vscode-extensions; [
      biomejs.biome
      charliermarsh.ruff
      github.copilot
      github.copilot-chat
      hediet.vscode-drawio
      humao.rest-client
      ms-python.debugpy
      ms-python.python
      ms-python.vscode-pylance
    ];

    userSettings = {
      files.autoSave = "onFocusChange";
      editor.formatOnSave = true;

      "[python]"."editor.defaultFormatter" = "charliermarsh.ruff";
      "[typescript]"."editor.defaultFormatter" = "biomejs.biome";
      "[typescriptreact]"."editor.defaultFormatter" = "biomejs.biome";

      "editor.codeActionsOnSave" = {
        "source.fixAll.biome" = "explicit";
        "source.organizeImports.biome" = "explicit";
      };
    };
  };
}
