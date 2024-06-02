{ pkgs, ... }: {
  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      monospace = [ "Input" ];
      emoji = [ "JoyPixels" ];
    };
  };

  home.packages = with pkgs; [
    font-awesome
    input-fonts
    joypixels
    (nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly" ]; })
  ];
}
