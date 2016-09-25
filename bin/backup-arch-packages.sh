#/bin/sh

# crontab -e
# 0 18 * * * /home/maximbaz/bin/backup-arch-packages.sh

pacman -Qe | awk '{ print $1 }' > /home/maximbaz/lib/arch.packages

