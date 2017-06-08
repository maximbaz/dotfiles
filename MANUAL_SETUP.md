# Thunderbird

- Enigmail
- GNotifier

  ```
  notify-send "%title" "%text" -i "%image"; wmctrl -r "Thunderbird" -b add,demands_attention
  ```

# Pacman

Uncomment in `/etc/pacman.conf`:
- Color
- VerbosePkgLists

# Cron

```
0    18 * * * /home/maximbaz/bin/backup-arch-packages.sh
*/5  *  * * * /home/maximbaz/bin/update-wallpaper.sh
```
