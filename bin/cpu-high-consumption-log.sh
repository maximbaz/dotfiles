#!/bin/sh

# crontab -e
# *    *  * * * /home/maximbaz/bin/cpu-high-consumption-log.sh

run() {
  (echo "%CPU %MEM ARGS $(date)" && ps -e -o pcpu,pmem,args --sort=pcpu | cut -d" " -f1-5 | tail) >> /var/log/cpu-usage.log
}

(sleep 5  && run) &
(sleep 10 && run) &
(sleep 15 && run) &
(sleep 20 && run) &
(sleep 25 && run) &
(sleep 30 && run) &
(sleep 35 && run) &
(sleep 40 && run) &
(sleep 45 && run) &
(sleep 50 && run) &
(sleep 55 && run) &
(sleep 60 && run) &
