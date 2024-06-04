{
  time.timeZone = "Europe/Copenhagen";

  i18n = {
    defaultLocale = "en_US.UTF-8";

    supportedLocales = [
      "en_US.UTF-8/UTF-8"
      "en_DK.UTF-8/UTF-8"
    ];

    extraLocaleSettings = {
      LC_MONETARY = "en_DK.UTF-8";
      LC_TIME = "en_DK.UTF-8";
    };
  };
}
