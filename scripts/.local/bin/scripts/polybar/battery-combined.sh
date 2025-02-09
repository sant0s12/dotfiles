#!/bin/sh

PATH_AC="/sys/class/power_supply/AC"
PATH_BATTERY_0="/sys/class/power_supply/BAT0"
PATH_BATTERY_1="/sys/class/power_supply/BAT1"

ac=0
battery_level_0=0
battery_level_1=0
battery_max_0=0
battery_max_1=0
battery_power_0=0
battery_power_1=0

if [ -f "$PATH_AC/online" ]; then
    ac=$(cat "$PATH_AC/online")
fi

if [ -f "$PATH_BATTERY_0/energy_now" ]; then
    battery_level_0=$(cat "$PATH_BATTERY_0/energy_now")
fi

if [ -f "$PATH_BATTERY_0/energy_full" ]; then
    battery_max_0=$(cat "$PATH_BATTERY_0/energy_full")
fi

if [ -f "$PATH_BATTERY_0/power_now" ]; then
    battery_power_0=$(cat "$PATH_BATTERY_0/power_now")
fi

if [ -f "$PATH_BATTERY_1/energy_now" ]; then
    battery_level_1=$(cat "$PATH_BATTERY_1/energy_now")
fi

if [ -f "$PATH_BATTERY_1/energy_full" ]; then
    battery_max_1=$(cat "$PATH_BATTERY_1/energy_full")
fi

if [ -f "$PATH_BATTERY_1/power_now" ]; then
    battery_power_1=$(cat "$PATH_BATTERY_1/power_now")
fi

battery_level=$(("$battery_level_0 + $battery_level_1"))
battery_max=$(("$battery_max_0 + $battery_max_1"))

battery_percent=$(("$battery_level * 100"))
battery_percent=$(("$battery_percent / $battery_max"))

if [ "$ac" -eq 1 ]; then
    icon="⚡"
   
    seconds=0
    if [ "$(($battery_power_0 + $battery_power_1))" -gt 0 ]; then
        seconds=$(bc <<< "scale = 10; (($battery_max - $battery_level)/($battery_power_0 + $battery_power_1)) * 3600")
    fi
    time=$(date -u -d @${seconds} +%H:%M)

    if [ "$battery_percent" -ge 97 ]; then
        echo "$icon"
    else
        echo "$icon $battery_percent% $time"
    fi
else

    seconds=0
    if [ "$(($battery_power_0 + $battery_power_1))" -gt 0 ]; then
        seconds=$(bc <<< "scale = 10; ($battery_level/($battery_power_0 + $battery_power_1)) * 3600")
    fi
    time=$(date -u -d @${seconds} +%H:%M)

    if [ "$battery_percent" -gt 95 ]; then
        icon=""
    elif [ "$battery_percent" -gt 90 ]; then
        icon=""
    elif [ "$battery_percent" -gt 80 ]; then
        icon=""
    elif [ "$battery_percent" -gt 70 ]; then
        icon=""
    elif [ "$battery_percent" -gt 60 ]; then
        icon=""
    elif [ "$battery_percent" -gt 50 ]; then
        icon=""
    elif [ "$battery_percent" -gt 40 ]; then
        icon=""
    elif [ "$battery_percent" -gt 30 ]; then
        icon=""
    elif [ "$battery_percent" -gt 20 ]; then
        icon=""
    elif [ "$battery_percent" -gt 10 ]; then
        icon=""
    else
        icon=""
    fi

    echo "$icon $battery_percent% $time"
fi
