#!/bin/sh
choice=$(printf "Lock\nShutdown\nReboot\nExit" | dmenu -i -p "Choose action: ")
[ "$choice" = "Lock"     ] && slock 2>/dev/null
[ "$choice" = "Shutdown" ] && doas poweroff 2>/dev/null
[ "$choice" = "Reboot"   ] && doas reboot 2>/dev/null
[ "$choice" = "Exit"     ] && pkill dwm

