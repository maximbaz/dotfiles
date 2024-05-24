{ lib
, stdenv
, fetchzip
, python3
}:

let
  releaseDate = "2015-06-24";
in
stdenv.mkDerivation rec {
  pname = "input-fonts-maximbaz";
  version = "1.2";

  src =
    fetchzip {
      name = "input-fonts-maximbaz-${version}";
      # This URL is too long for fetchzip, and returns non-reproducible zips with new sha256 every time ☹️
      # url = "https://input.djr.com/build/?customize&fontSelection=fourStyleFamily&regular=InputMonoNarrow-Regular&italic=InputMonoNarrow-Italic&bold=InputMonoNarrow-Bold&boldItalic=InputMonoNarrow-BoldItalic&a=0&g=0&i=serifs_round&l=serifs_round&zero=slash&asterisk=height&braces=0&preset=default&line-height=1.1&accept=I+do&email=";
      url = "https://maximbaz.com/input-fonts.zip";
      sha256 = "09qfb3h2s1dlf6kn8d4f5an6jhfpihn02zl02sjj26zgclrp6blc";
      stripRoot = false;

      postFetch = ''
        # Reset the timestamp to release date for determinism.
        PATH=${lib.makeBinPath [ python3.pkgs.fonttools ]}:$PATH
        for ttf_file in $out/Input_Fonts/*/*/*.ttf; do
          ttx_file=$(dirname "$ttf_file")/$(basename "$ttf_file" .ttf).ttx
          ttx "$ttf_file"
          rm "$ttf_file"
          touch -m -t ${builtins.replaceStrings [ "-" ] [ "" ] releaseDate}0000 "$ttx_file"
          ttx --recalc-timestamp "$ttx_file"
          rm "$ttx_file"
        done
      '';
    };

  dontConfigure = true;
  dontBuild = true;

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/fonts/truetype
    find Input_Fonts -name "*.ttf" -exec cp -a {} "$out"/share/fonts/truetype/ \;
    mkdir -p "$out"/share/doc
    cp -a *.txt "$out"/share/doc/

    runHook postInstall
  '';

  meta = with lib; {
    description = "Fonts for Code, from Font Bureau - maximbaz style";
    longDescription = ''
      Input is a font family designed for computer programming, data,
      and text composition. It was designed by David Jonathan Ross
      between 2012 and 2014 and published by The Font Bureau. It
      contains a wide array of styles so you can fine-tune the
      typography that works best in your editing environment.

      Input Mono is a monospaced typeface, where all characters occupy
      a fixed width. Input Sans and Serif are proportional typefaces
      that are designed with all of the features of a good monospace —
      generous spacing, large punctuation, and easily distinguishable
      characters — but without the limitations of a fixed width.
    '';
    homepage = "https://input.djr.com/";
    license = licenses.unfree;
    platforms = platforms.all;
  };
}
