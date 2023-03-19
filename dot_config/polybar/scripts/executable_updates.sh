#!/usr/bin/bash

NOTIFY_ICON=/usr/share/icons/Papirus/32x32/apps/system-software-update.svg

get_total_updates() { UPDATES=$(checkupdates 2>/dev/null | wc -l); }

while true; do
	get_total_updates

	# notify user of updates
	if hash notify-send &>/dev/null; then
		if (( UPDATES > 50 )); then
			notify-send -u critical -i $NOTIFY_ICON "Vous devez faire les mises à jours !" "$UPDATES Nouveaux packages"
		elif (( UPDATES > 2 )); then
			notify-send -u low -i $NOTIFY_ICON "$UPDATES Nouveaux packages"
		fi
	fi

	# when there are updates available
	# every 10 seconds another check for updates is done
	while (( UPDATES > 0 )); do
		if (( UPDATES == 1 )); then
			echo "$UPDATES"
		elif (( UPDATES > 1 )); then
			echo "$UPDATES"
		else
			echo "Aucun"
		fi
		sleep 10
		get_total_updates
	done

	# when no updates are available, use a longer loop, this saves on CPU
	# and network uptime, only checking once every 30 min for new updates
	while (( UPDATES == 0 )); do
		echo "Aucun"
		sleep 1800
		get_total_updates
	done
done
