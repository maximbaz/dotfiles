{
  # https://github.com/LnL7/nix-darwin/pull/787
  # security.pam.enableSudoTouchIdAuth = true;
  environment.etc."pam.d/sudo_local".text = ''
    auth sufficient pam_tid.so
  '';
}
