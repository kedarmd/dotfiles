#!/usr/bin/env bash
tokyonight="🌃 Tokyonight"
catppuccin="🐱 Catppuccin"
onedark="🌙 Onedark"
nord="🌲 Nord"
options="$tokyonight\n$catppuccin\n$onedark\n$nord"

choice=$(echo -e $options | rofi -dmenu -normal-window -i -p "Theme")

case $choice in
  "$tokyonight")
    kmdot -t tokyonight -v storm
    ;;
  "$catppuccin")
    kmdot -t catppuccin -v mocha
    ;;
  "$onedark")
    kmdot -t onedark
    ;;
  "$nord")
    kmdot -t nord
    ;;
esac
