{ lib, pkgs, ... }: {
  programs.git = {
    enable = true;

    userName = "Maxim Baz";
    userEmail = "git@maximbaz.com";

    signing = {
      key = "04D7A219B0ABE4C2B62A5E654A2B758631E1FD91";
      signByDefault = true;
    };

    extraConfig = {
      advice.detachedHead = false;
      branch.autosetuprebase = "always";

      color = {
        branch = {
          current = "green reverse";
          local = "green";
          remote = "yellow";
        };

        status = {
          added = "green";
          changed = "yellow";
          untracked = "blue";
        };
      };

      core = {
        autocrlf = "input";
        untrackedCache = true;
      };

      diff = {
        colorMoved = "default";

        gpg = {
          binary = true;
          textconv = "${lib.getExe pkgs.gnupg} --decrypt --quiet --yes --compress-algo=none --no-encrypt-to --batch --use-agent";
        };
      };

      init.defaultBranch = "main";
      push.default = "current";

      rebase = {
        autostash = true;
        autosquash = true;
      };

      user.useConfigOnly = true;
    };

    includes = [{
      condition = "gitdir:~/maersk/";
      contents = {
        user = {
          email = "Maxim.Baz@maersk.com";
          signingKey = "256CFDF971216A011DE08CD2C44E48E507AA28B1";
        };
        url = {
          "git@github-maersk:Maersk-Global" = {
            insteadOf = [
              "https://github.com/Maersk-Global"
              "git@github.com:Maersk-Global"
            ];
          };
        };
      };
    }];

    ignores = [
      ".direnv"
      "__pycache__"
      "node_modules"
      "*.log"
    ];

    delta = {
      enable = true;
      options = {
        features = "hyperlinks";
        file-added-label = "[+]";
        file-copied-label = "[C]";
        file-decoration-style = "yellow ul";
        file-modified-label = "[M]";
        file-removed-label = "[-]";
        file-renamed-label = "[R]";
        file-style = "yellow bold";
        hunk-header-decoration-style = "omit";
        hunk-header-style = "syntax italic #303030";
        minus-emph-style = "syntax bold #780000";
        minus-style = "syntax #400000";
        plus-emph-style = "syntax bold #007800";
        plus-style = "syntax #004000";
        syntax-theme = "gruvbox-dark";
        width = 1;
      };
    };
  };
}
