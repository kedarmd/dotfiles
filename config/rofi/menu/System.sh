#!/usr/bin/env bash

options=" Shutdown\n Restart\n Suspend\n Logout"

choice=$(echo -e $options | rofi -dmenu -normal-window -i -p "System")

case $choice in
  " Shutdown")
    systemctl poweroff
    ;;
  " Restart")
    systemctl reboot
    ;;
  " Suspend")
    systemctl suspend
    ;;
  " Logout")
    bspc quit
    ;;
esac
