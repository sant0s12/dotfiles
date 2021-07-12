#!/bin/sh

# Set displays
xrandr --output eDP1 --primary && xrandr --output HDMI1 --auto --above eDP1

# Start compositor
killall picom ; picom -CGb --experimental-backends

# Start dunst
killall dunst ; dunst

# Set wallpaper and theme
[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources

# Start polybar
setsid $XDG_CONFIG_HOME/polybar/launch.sh

# Auto tiling
autotiling
