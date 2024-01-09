{
    allowUnfree = true;
    allowBroken = true;

    packageOverrides = pkgs: with pkgs; {
        maximbaz = pkgs.buildEnv {
            name = "maximbaz";
            paths = [
                (python311.withPackages (ps: with ps; [
                    pyyaml
                    pynacl
                    pylint
                    tldextract
                    isort
                    black
                    pip
                ]))

                azure-cli
                bash
                bat
                coreutils
                curl
                delta
                diffutils
                direnv
                dos2unix
                editorconfig-core-c
                eza
                fd
                findutils
                fzf
                gawk
                gh
                git
                gnugrep
                gnum4
                gnumake
                gnused
                gnutar
                gnutls
                go
                gopls
                gzip
                kubelogin
                kubernetes-helm
                htop
                jq
                kak-lsp
                kakoune
                kubectl
                kubectx
                less
                nodePackages.prettier
                openssh
                sshpass
                pass
                patch
                pgcli
                postgresql
                qrencode
                ripgrep
                rsync
                rust-analyzer
                shellcheck
                sipcalc
                terraform
                tig
                tree
                unixtools.watch
                unzip
                vault
                vim
                #webwormhole
                wget
                wireguard-tools
                wireguard-go
                which
                xplr
                yq
                zsh
                zstd
                mtr
            ];
        };
    };
}
