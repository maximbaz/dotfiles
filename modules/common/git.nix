{ config, lib, pkgs, ... }: {
  home-manager.users.${config.user} = {
    home.packages = with pkgs; [
      mergiraf
      tig
    ];

    home.file.".config/git/gitattributes".text = ''
      *.java merge=mergiraf
      *.rs merge=mergiraf
      *.go merge=mergiraf
      *.js merge=mergiraf
      *.jsx merge=mergiraf
      *.json merge=mergiraf
      *.yml merge=mergiraf
      *.yaml merge=mergiraf
      *.toml merge=mergiraf
      *.html merge=mergiraf
      *.htm merge=mergiraf
      *.xhtml merge=mergiraf
      *.xml merge=mergiraf
      *.c merge=mergiraf
      *.cc merge=mergiraf
      *.h merge=mergiraf
      *.cpp merge=mergiraf
      *.hpp merge=mergiraf
      *.cs merge=mergiraf
      *.dart merge=mergiraf
      *.scala merge=mergiraf
      *.sbt merge=mergiraf
      *.ts merge=mergiraf
      *.py merge=mergiraf
    '';

    home.file.".ssh/allowed_signers".text =
      "* ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIrS8858Xqs+RsxNpVNKdpCAYdbTtel1G28MQBVyIQe8";

    programs.git = {
      enable = true;

      userName = "Max Baz";
      userEmail = "noreply-git@baz.nu";

      signing = {
        key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIrS8858Xqs+RsxNpVNKdpCAYdbTtel1G28MQBVyIQe8";
        format = "ssh";
        signByDefault = true;
      };

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
          attributesFile = "~/.config/git/gitattributes";
        };

        diff = {
          colorMoved = "default";

          gpg = {
            binary = true;
            textconv = "${lib.getExe pkgs.gnupg} --decrypt --quiet --yes --compress-algo=none --no-encrypt-to --batch --use-agent";
          };
        };

        gpg.ssh.allowedSignersFile = "~/.ssh/allowed_signers";

        init.defaultBranch = "main";

        merge.mergiraf = {
          name = "mergiraf";
          driver = "${lib.getExe pkgs.mergiraf} merge --git %O %A %B -s %S -x %X -y %Y -p %P";
        };

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
        ".DS_Store"
      ];
    };
  };
}
