{ config, ... }: {
  home-manager.users.${config.user}.xdg.configFile."wldash/config.yaml".text = ''
    ---
    outputMode: active
    scale: 2
    background:
      red: 0.14
      green: 0.14
      blue: 0.14
      opacity: 1
    widget: !margin
      margins: [30, 30, 30, 30]
      widget: !verticalLayout
        - !horizontalLayout
          - !margin
            margins: [0, 132, 0, 48]
            widget: !verticalLayout
              - !date
                font: ~
                font_size: 96.0
              - !clock
                font: ~
                font_size: 384.0
          - !verticalLayout
            - !margin
              margins: [0, 0, 0, 12]
              widget: !battery
                font: ~
                font_size: 36.0
                length: 0
        - !calendar
          font_primary: ~
          font_secondary: ~
          font_size: 24.0
          sections: 3
        - !launcher
          font: ~
          font_size: 48.0
          length: 0
          app_opener: "cglaunch"
          term_opener: "cglaunch --term"
          url_opener: "xdg-open"

    fonts:
      sans: sans
      mono: mono
  '';
}
