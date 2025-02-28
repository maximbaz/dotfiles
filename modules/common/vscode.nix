{ config, pkgs, ... }: {
  home-manager.users.${config.user}.programs.vscode = {
    enable = true;
    enableUpdateCheck = false;

    extensions = with pkgs; [
      vscode-extensions.biomejs.biome
      vscode-extensions.charliermarsh.ruff
      vscode-extensions.github.copilot
      vscode-extensions.github.copilot-chat
      vscode-extensions.hediet.vscode-drawio
      vscode-extensions.humao.rest-client
      vscode-extensions.ms-python.debugpy
      vscode-extensions.ms-python.python
      vscode-extensions.ms-python.vscode-pylance
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
