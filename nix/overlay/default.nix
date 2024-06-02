final: prev: {
  input-fonts = prev.input-fonts.overrideAttrs (_old: {
    src = prev.fetchzip {
      # This URL is too long for fetchzip, and returns non-reproducible zips with new sha256 every time ☹️
      # url = "https://input.djr.com/build/?customize&fontSelection=fourStyleFamily&regular=InputMonoNarrow-Regular&italic=InputMonoNarrow-Italic&bold=InputMonoNarrow-Bold&boldItalic=InputMonoNarrow-BoldItalic&a=0&g=0&i=serifs_round&l=serifs_round&zero=slash&asterisk=height&braces=0&preset=default&line-height=1.1&accept=I+do&email=";
      url = "https://maximbaz.com/input-fonts.zip";
      sha256 = "09qfb3h2s1dlf6kn8d4f5an6jhfpihn02zl02sjj26zgclrp6blc";
      stripRoot = false;
    };
  });

  wldash = prev.wldash.override (old: {
    rustPlatform = old.rustPlatform // {
      buildRustPackage = args: old.rustPlatform.buildRustPackage (args // {
        src = prev.fetchFromGitHub {
          owner = "cyrinux";
          repo = "wldash";
          rev = "9cc29f2507a746ef6359dd081d9f2fe2f43c2a23";
          hash = "sha256-aATJIHETQDX1UXkn5/1jVESgdQFbTFySYuL01NvP54s=";
        };
        cargoSha256 = "sha256-Ot+GnnbFFS6e86uhNDoujlX/oQX9Ckp+M467sXJOD60=";
        cargoPatches = [ ];
      });
    };
  });
}
