{ config, ... }: {
  home-manager.users.${config.user}.xdg.configFile."sworkstyle/config.toml".text = ''
    fallback = ""

    [matching]
    "calibre-gui" = ""
    "chromium" = ""
    "code" = ""
    "dmenu" = ""
    "dmenu-clipboard" = ""
    "dmenu-browser" = ""
    "dmenu-emoji" = ""
    "dmenu-pass generator" = ""
    "firefox" = ""
    "kitty" = ""
    "krita" = ""
    "libreoffice-calc" = ""
    "libreoffice-writer" = ""
    "mpv" = ""
    "neomutt" = ""
    "org.pwmt.zathura" = ""
    "pavucontrol" = ""
    "peek" = ""
    "qalculate-gtk" = ""
    "signal" = ""
    "swappy" = ""
    "vimiv" = ""
  '';
}
