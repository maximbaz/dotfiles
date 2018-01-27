# Patches prezto with my own adjustments
prezto_apply_patches() (
  if [ "$(whoami)" != "root" ]; then
    cd "$HOME/.antigen/bundles/sorin-ionescu/prezto"
    patch -p1 -f -r - --no-backup-if-mismatch < "$HOME/.dotfiles/.zprezto-patches/prompt.patch" >/dev/null 2>&1
    patch -p1 -f -r - --no-backup-if-mismatch < "$HOME/.dotfiles/.zprezto-patches/wordchars.patch" >/dev/null 2>&1
  fi
)

# Revert applied patches (needed for updates)
prezto_revert_patches() (
  if [ "$(whoami)" != "root" ]; then
    cd "$HOME/.antigen/bundles/sorin-ionescu/prezto"
    git reset --hard HEAD >/dev/null 2>&1
  fi
)

# Apply patches asynchronously
prezto_apply_patches &!
