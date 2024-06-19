{
  # https://github.com/LnL7/nix-darwin/pull/787
  environment.etc."pam.d/sudo_local".text = ''
    auth sufficient pam_tid.so
  '';
}
