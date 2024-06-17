{
  home.file.".w3m/config".text = ''
    confirm_qq 0
    use_history 0
  '';

  home.file.".w3m/keymap".text = ''
    keymap C-d NEXT_HALF_PAGE
    keymap C-u PREV_HALF_PAGE
  '';
}
