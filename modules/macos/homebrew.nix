{
  system.activationScripts.preUserActivation.text = ''
    if ! xcode-select --version 2>/dev/null; then
      xcode-select --install
    fi
    if ! /opt/homebrew/bin/brew --version 2>/dev/null; then
      /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
  '';

  homebrew = {
    enable = true;
    onActivation = {
      cleanup = "zap";
      upgrade = true;
    };
    brews = [
      "coreutils"
      # "cairo"
      # "pango"
      # "libpng"
      # "jpeg"
      # "giflib"
      # "librsvg"
    ];
    casks = [
      "bluesnooze"
      "browserosaurus"
      "docker"
      "figma"
      "google-chrome"
      "arc"
      "zed"
      "utm"
      "firefox@developer-edition"
      "karabiner-elements"
      # "raycast" 
      "appcleaner"
      "microsoft-teams"
      "microsoft-outlook"
      "microsoft-remote-desktop"
      "spotify"
      "signal"
      "slack"
      "discord"
      "notion"
      "postman"
      "jupyterlab"
    ];
  };
}
