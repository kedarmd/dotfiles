#!/usr/bin/env bash

shutdown=" Shutdown"
restart=" Restart"
suspend=" Suspend"
logout=" Logout"
options="$shutdown\n$restart\n$suspend\n$logout"

choice=$(echo -e $options | rofi -dmenu -normal-window -i -p "System")

case $choice in
  "$shutdown")
    systemctl poweroff
    ;;
  "$restart")
    systemctl reboot
    ;;
  "$suspend")
    systemctl suspend
    ;;
  "$logout")
    bspc quit
    ;;
esac
