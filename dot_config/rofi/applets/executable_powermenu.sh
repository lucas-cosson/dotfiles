#!/bin/bash

dir="$HOME/.config/rofi/applets"
rofi_command="rofi -theme $dir/powermenu.rasi"

uptime=$(uptime -p | sed -e 's/up //g')

# Options
shutdown="襤"
reboot=""
lock=""
suspend=""
logout="﫻"

confirm_exit() {
    rofi -dmenu\
    -i\
    -no-fixed-num-lines\
    -p "Êtes-vous sur ? : "\
    -theme $dir/confirm.rasi
}

msg() {
    rofi -theme "$dir/message.rasi" -e "Options  -  oui / o / non / n"
}

# Variable passed to rofi
options="$shutdown\n$reboot\n$lock\n$suspend\n$logout"

chosen="$(echo -e "$options" | $rofi_command -p "Uptime: $uptime" -dmenu -selected-row 2)"
case $chosen in
    $shutdown)
        ans=$(confirm_exit &)
        if [[ $ans == "oui" || $ans == "OUI" || $ans == "o" || $ans == "o" ]]; then
            systemctl poweroff
            elif [[ $ans == "non" || $ans == "NON" || $ans == "n" || $ans == "N" ]]; then
            exit 0
        else
            msg
        fi
    ;;
    $reboot)
        ans=$(confirm_exit &)
        if [[ $ans == "oui" || $ans == "OUI" || $ans == "o" || $ans == "O" ]]; then
            systemctl reboot
            elif [[ $ans == "non" || $ans == "NON" || $ans == "n" || $ans == "N" ]]; then
            exit 0
        else
            msg
        fi
    ;;
    $lock)
		betterlockscreen -l dim
    ;;
    $suspend)
        ans=$(confirm_exit &)
        if [[ $ans == "oui" || $ans == "OUI" || $ans == "o" || $ans == "O" ]]; then
            amixer set Master mute
            systemctl suspend
            elif [[ $ans == "non" || $ans == "NON" || $ans == "n" || $ans == "N" ]]; then
            exit 0
        else
            msg
        fi
    ;;
    $logout)
        ans=$(confirm_exit &)
        if [[ $ans == "oui" || $ans == "OUI" || $ans == "o" || $ans == "O" ]]; then
            i3-msg exit
            elif [[ $ans == "non" || $ans == "NON" || $ans == "n" || $ans == "N" ]]; then
            exit 0
        else
            msg
        fi
    ;;
esac
