{ pkgs, ... }: {
  nixpkgs.overlays = [
    (self: super: {
      input-fonts = super.input-fonts.overrideAttrs (_old: {
        src = super.fetchzip {
          # This URL is too long for fetchzip, and returns non-reproducible zips with new sha256 every time ☹️
          # url = "https://input.djr.com/build/?customize&fontSelection=fourStyleFamily&regular=InputMonoNarrow-Regular&italic=InputMonoNarrow-Italic&bold=InputMonoNarrow-Bold&boldItalic=InputMonoNarrow-BoldItalic&a=0&g=0&i=serifs_round&l=serifs_round&zero=slash&asterisk=height&braces=0&preset=default&line-height=1.1&accept=I+do&email=";
          url = "https://maximbaz.com/input-fonts.zip";
          sha256 = "09qfb3h2s1dlf6kn8d4f5an6jhfpihn02zl02sjj26zgclrp6blc";
          stripRoot = false;
        };
      });

      wldash = super.wldash.override (old: {
        rustPlatform = old.rustPlatform // {
          buildRustPackage = args: old.rustPlatform.buildRustPackage (args // {
            src = super.fetchFromGitHub {
              owner = "cyrinux";
              repo = "wldash";
              rev = "9cc29f2507a746ef6359dd081d9f2fe2f43c2a23";
              hash = "sha256-aATJIHETQDX1UXkn5/1jVESgdQFbTFySYuL01NvP54s=";
            };
            useFetchCargoVendor = true;
            cargoHash = "sha256-xuyUKKAIGEJwl9mcNQLFhk5r6+YSl+0EkUHPk//gM9c=";
            cargoPatches = [ ];
          });
        };
      });

      joypixels = super.joypixels.overrideAttrs (_old: {
        version = "9.0.0";
        src = super.fetchurl {
          name = "joypixels-android.ttf";
          url = "https://maximbaz.com/joypixels-emoji.ttf";
          sha256 = "0ghh5s4ri4lpf43nnpjck9g3y6s4cl9mwkjq78wzfaqj0rbaqqd6";
        };
      });

      pik = super.rustPlatform.buildRustPackage rec {
        pname = "pik";
        version = "0.9.0";

        src = super.fetchFromGitHub {
          owner = "jacek-kurlit";
          repo = pname;
          rev = version;
          hash = "sha256-YAnMSVQu/E+OyhHX3vugfBocyi++aGwG9vF6zL8T2RU=";
        };

        useFetchCargoVendor = true;
        cargoHash = "sha256-vXE9AL0+WCPhwJTqglwOhIeqhI+JQB3Cr8GBQjmW+zc=";
      };

      maximbaz-scripts = pkgs.stdenv.mkDerivation {
        pname = "maximbaz-scripts";
        version = "1.0.0";
        src = ./bin;
        dontUnpack = true;
        nativeBuildInputs = [ pkgs.makeWrapper ];
        installPhase = ''
          install -Dm755 $src/* -t $out/bin/
          install -Dm755 $src/dmenu $out/bin/dmenu-wl
        '';
        postFixup = ''
          for script in $out/bin/*; do 
            wrapProgram $script \
              --suffix PATH : /run/wrappers/bin/ \
              --suffix PATH : /etc/profiles/per-user/maximbaz/bin/ \
              --suffix PATH : /run/current-system/sw/bin/ \
              ;
          done
        '';
      };
    })
  ];
}
