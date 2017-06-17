#/bin/sh

# crontab -e
# 0 18 * * * /home/maximbaz/bin/backup-pacman-list.sh

pacman -Qnqe > /home/maximbaz/lib/pacman.native.list
pacman -Qmqe > /home/maximbaz/lib/pacman.foreign.list
