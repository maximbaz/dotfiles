# thunderbird

- Enigmail
- GNotifier

```
notify-send "%title" "%text" -i "%image"; wmctrl -r "Thunderbird" -b add,demands_attention
```

# pacman

- Uncomment in `/etc/pacman.conf`:
  - Color
  - VerbosePkgLists

# sudo

- Allow some apps use sudo without asking for password:

```
$ sudo visudo

%wheel ALL=(ALL) ALL
%wheel ALL=(ALL) NOPASSWD:SETENV: /usr/bin/pacman, /usr/bin/umount
```

# cron

```
0    18 * * * /home/maximbaz/bin/backup-arch-packages.sh
*/5  *  * * * /home/maximbaz/bin/update-wallpaper.sh
```
