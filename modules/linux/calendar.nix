{ config, ... }: {
  home-manager.users.${config.user} = {
    programs.thunderbird = {
      enable = true;

      profiles."default".isDefault = true;

      settings = {
        "app.update.auto" = false;
        "mail.biff.play_sound" = false;
        "mail.biff.show_alert" = false;
        "mail.shell.checkDefaultClient" = false;
        "mailnews.start_page.enabled" = false;
        "privacy.donottrackheader.enabled" = true;
      };
    };
  };
}
