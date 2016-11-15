#!/bin/bash
sleep 1
scrot /tmp/screen.png
convert /tmp/screen.png -scale 10% -scale 1000% /tmp/screen.png
convert /tmp/screen.png -gravity center -composite -matte /tmp/screen.png
i3lock -i /tmp/screen.png
rm /tmp/screen.png

if [ "$1" == "suspend" ]; then
    systemctl suspend
elif [ "$1" == "hibernate" ]; then
    systemctl hibernate
fi
