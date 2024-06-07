{ pkgs, ... }: {
  programs.helix = {
    enable = true;
    defaultEditor = true;
    extraPackages = [
      pkgs.biome
      pkgs.clang-tools
      pkgs.docker-compose-language-service
      pkgs.dockerfile-language-server-nodejs
      pkgs.golangci-lint
      pkgs.golangci-lint-langserver
      pkgs.gopls
      pkgs.gotools
      pkgs.helix-gpt
      pkgs.marksman
      pkgs.nil
      pkgs.nixpkgs-fmt
      pkgs.nodePackages.bash-language-server
      pkgs.nodePackages.prettier
      pkgs.nodePackages.typescript-language-server
      pkgs.pgformatter
      (pkgs.python3.withPackages (p: (with p; [
        black
        isort
        python-lsp-black
        python-lsp-server
      ])))
      pkgs.rust-analyzer
      pkgs.taplo
      pkgs.taplo-lsp
      pkgs.terraform-ls
      pkgs.vscode-langservers-extracted
      pkgs.yaml-language-server
    ];

    settings = {
      theme = "gruvbox_community";

      editor = {
        color-modes = true;
        auto-save = true;
        cursorline = true;
        bufferline = "multiple";
      };

      editor.cursor-shape = {
        insert = "bar";
        normal = "block";
        select = "underline";
      };

      editor.file-picker = {
        hidden = false;
        ignore = false;
      };

      editor.indent-guides = {
        character = "┊";
        render = true;
        skip-levels = 1;
      };

      editor.lsp = {
        display-inlay-hints = true;
        display-messages = true;
      };

      editor.statusline = {
        left = [ "mode" "file-name" "spinner" "read-only-indicator" "file-modification-indicator" ];
        right = [ "diagnostics" "selections" "register" "file-type" "file-line-ending" "position" ];
        mode.normal = "";
        mode.insert = "I";
        mode.select = "S";
      };

      keys.normal = {
        H = "extend_char_left";
        J = [ "extend_line_down" "extend_to_line_bounds" ];
        K = [ "extend_line_up" "extend_to_line_bounds" ];
        L = "extend_char_right";
        B = "extend_prev_word_start";
        W = "extend_next_word_start";
        E = "extend_next_word_end";
        A-b = "move_prev_long_word_start";
        A-B = "extend_prev_long_word_start";
        A-w = "move_next_long_word_start";
        A-W = "extend_next_long_word_start";
        A-e = "move_next_long_word_end";
        A-E = "extend_next_long_word_end";
        T = "extend_till_char";
        F = "extend_next_char";
        A-t = "till_prev_char";
        A-f = "find_prev_char";
        A-T = "extend_till_prev_char";
        A-F = "extend_prev_char";
        A-j = "join_selections";
        A-k = "keep_selections";
        M = [ "select_mode" "match_brackets" "normal_mode" ];
        "#" = "toggle_comments";
        A-l = "extend_to_line_end";
        A-h = "extend_to_line_start";
        left = "goto_previous_buffer";
        right = "goto_next_buffer";
        A-d = "delete_selection";
        c = "change_selection_noyank";
        d = "delete_selection_noyank";
        N = "extend_search_next";
        A-n = "search_prev";
        A-N = "extend_search_prev";
        C-d = [ "page_cursor_half_down" "align_view_center" ];
        C-u = [ "page_cursor_half_up" "align_view_center" ];
        tab = "move_parent_node_end";
        S-tab = "move_parent_node_start";
      };

      keys.normal.g = {
        j = "goto_last_line";
        k = "goto_file_start";
      };

      keys.normal.space = {
        c = ":buffer-close";
        A-f = ":toggle auto-format";
        q = ":write-quit-all";
        Q = ":quit!";
        e = ":config-open";
        w = ":write";
        "." = ":toggle file-picker.git-ignore";
      };

      keys.insert = {
        C-u = [ "extend_to_line_bounds" "delete_selection_noyank" "open_above" ];
        C-w = [ "move_prev_word_start" "delete_selection_noyank" ];
        C-space = "completion";
        S-tab = "move_parent_node_start";
      };

      keys.select = {
        tab = "extend_parent_node_end";
        S-tab = "extend_parent_node_start";
      };
    };

    themes = {
      # https://github.com/helix-editor/helix/blob/master/runtime/themes/gruvbox.toml
      gruvbox_community = {
        inherits = "gruvbox";
        "variable" = "blue1";
        "variable.parameter" = "blue1";
        "function.macro" = "red1";
        "operator" = "orange1";
        "comment" = "gray1";
        "constant.builtin" = "orange1";
        "ui.background" = { };
      };
    };

    languages = {
      language-server.biome = {
        command = "biome";
        args = [ "lsp-proxy" ];
      };

      language-server.gpt = {
        command = "helix-gpt";
        args = [ "--handler" "copilot" ];
      };

      language-server.rust-analyzer.config.check = {
        command = "clippy";
      };

      language-server.yaml-language-server.config.yaml.schemas = {
        kubernetes = "k8s/*.yaml";
      };

      language = [
        {
          name = "css";
          language-servers = [ "vscode-css-language-server" "gpt" ];
          formatter = {
            command = "prettier";
            args = [ "--stdin-filepath" "file.css" ];
          };
          auto-format = true;
        }
        {
          name = "go";
          language-servers = [ "gopls" "golangci-lint-lsp" "gpt" ];
          formatter = {
            command = "goimports";
          };
          auto-format = true;
        }
        {
          name = "html";
          language-servers = [ "vscode-html-language-server" "gpt" ];
          formatter = {
            command = "prettier";
            args = [ "--stdin-filepath" "file.html" ];
          };
          auto-format = true;
        }
        {
          name = "javascript";
          language-servers = [
            { name = "typescript-language-server"; except-features = [ "format" ]; }
            "biome"
            "gpt"
          ];
          auto-format = true;
        }
        {
          name = "json";
          language-servers = [
            { name = "vscode-json-language-server"; except-features = [ "format" ]; }
            "biome"
            "gpt"
          ];
          formatter = {
            command = "biome";
            args = [ "format" "--indent-style" "space" "--stdin-file-path" "file.json" ];
          };
          auto-format = true;
        }
        {
          name = "jsonc";
          language-servers = [
            { name = "vscode-json-language-server"; except-features = [ "format" ]; }
            "biome"
            "gpt"
          ];
          formatter = {
            command = "biome";
            args = [ "format" "--indent-style" "space" "--stdin-file-path" "file.jsonc" ];
          };
          auto-format = true;
        }
        {
          name = "jsx";
          language-servers = [
            { name = "typescript-language-server"; except-features = [ "format" ]; }
            "biome"
            "gpt"
          ];
          formatter = {
            command = "biome";
            args = [ "format" "--indent-style" "space" "--stdin-file-path" "file.jsx" ];
          };
          auto-format = true;
        }
        {
          name = "markdown";
          language-servers = [ "marksman" "gpt" ];
          formatter = {
            command = "prettier";
            args = [ "--stdin-filepath" "file.md" ];
          };
          auto-format = true;
        }
        {
          name = "nix";
          formatter = {
            command = "nixpkgs-fmt";
          };
          auto-format = true;
        }
        {
          name = "python";
          language-servers = [ "pylsp" "gpt" ];
          formatter = {
            command = "sh";
            args = [ "-c" "isort --profile black - | black -q -" ];
          };
          auto-format = true;
        }
        {
          name = "rust";
          language-servers = [ "rust-analyzer" "gpt" ];
          auto-format = true;
        }
        {
          name = "scss";
          language-servers = [ "vscode-css-language-server" "gpt" ];
          formatter = {
            command = "prettier";
            args = [ "--stdin-filepath" "file.scss" ];
          };
          auto-format = true;
        }
        {
          name = "sql";
          language-servers = [ "gpt" ];
          formatter = {
            command = "pg_format";
            args = [ "-iu1" "--no-space-function" "-" ];
          };
          auto-format = true;
        }
        {
          name = "toml";
          language-servers = [ "taplo" "gpt" ];
          formatter = {
            command = "taplo";
            args = [ "fmt" "-o" "column_width=120" "-" ];
          };
          auto-format = true;
        }
        {
          name = "tsx";
          language-servers = [
            { name = "typescript-language-server"; except-features = [ "format" ]; }
            "biome"
            "gpt"
          ];
          formatter = {
            command = "biome";
            args = [ "format" "--indent-style" "space" "--stdin-file-path" "file.tsx" ];
          };
          auto-format = true;
        }
        {
          name = "typescript";
          language-servers = [
            { name = "typescript-language-server"; except-features = [ "format" ]; }
            "biome"
            "gpt"
          ];
          formatter = {
            command = "biome";
            args = [ "format" "--indent-style" "space" "--stdin-file-path" "file.ts" ];
          };
          auto-format = true;
        }
        {
          name = "yaml";
          language-servers = [ "yaml-language-server" "gpt" ];
          formatter = {
            command = "prettier";
            args = [ "--stdin-filepath" "file.yaml" ];
          };
          auto-format = true;
        }
      ];
    };
  };
}
