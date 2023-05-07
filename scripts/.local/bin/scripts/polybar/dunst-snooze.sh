#!/bin/sh

case "$1" in
    --toggle)
        dunstctl set-paused toggle
        ;&
    *)
        if [ "$(dunstctl is-paused)" = "true" ]; then
            echo "%{F#cc241d}%{F-} "
        else
            echo " "
        fi
        ;;
esac
