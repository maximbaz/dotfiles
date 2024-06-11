#!/bin/sh

need_notify_low=1
need_notify_critical=1

while true; do
    acpi="$(acpi -b)"
    percent="$(echo "$acpi" | grep -P -o '[0-9]+(?=%)')"
    status="$(echo "$acpi" | grep -P -o '(?<=: )[^,]+')"

    if [ "$status" = "Discharging" ]; then
        if [ "$need_notify_critical" -eq 1 ] && [ "$percent" -le 15 ]; then
            notify-send -u critical -i battery-empty-symbolic "Battery level is critically low" "$percent% remaining"
            need_notify_critical=0
            need_notify_low=0
        elif [ "$need_notify_low" -eq 1 ] && [ "$percent" -le 30 ]; then
            notify-send -i battery-low-symbolic "Battery level is low" "$percent% remaining"
            need_notify_low=0
        fi
    else
        need_notify_low=1
        need_notify_critical=1
    fi

    sleep 5m
done
