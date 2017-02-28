#!/bin/sh

# crontab -e
# 0    19 * * * /home/maximbaz/bin/cpu-high-consumption-clean.sh

echo "$(tail -200000 /var/log/cpu-usage.log)" > /var/log/cpu-usage.log
