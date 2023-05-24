#!/bin/sh

DIR=$(dirname "$0")
cd "$DIR"

mkdir -p "$USERDATA_PATH/.wifi"

if [ ! -f /mnt/SDCARD/.system/paks/WiFi.pak/8188fu.ko ]; then
	show okay.png
	say "WiFi driver is missing!"$'\n'"Please reinstall DotUI."
	confirm any
	exit 0
fi

WIFI_ON=0
if [ -f "$USERDATA_PATH/.wifi/wifi_on.txt" ]; then
	if [ -f /appconfigs/wpa_supplicant.conf ]; then
		WIFI_ON=1
	else
		LD_PRELOAD= ./wifioff.sh > /dev/null 2>&1 &
	fi
fi

_WIFI_ON=$WIFI_ON
while :; do
	if [ ! -f /appconfigs/wpa_supplicant.conf ]; then
		show ./wifi2.png
		say "WiFi: Not configured"$'\n'$'\n'"Please configure your WiFi network"$'\n'"by pressing SELECT."
	else
		show ./wifi.png
		if [ $WIFI_ON -eq 1 ]; then
			say "WiFi: Enabled"
		else
			say "WiFi: Disabled"
		fi
	fi
	while :; do
		confirm any
		KEY=$?
		if [ $KEY -eq 57 ]; then  # 57 = A
			if [ -f /appconfigs/wpa_supplicant.conf ]; then
				WIFI_ON=$(( ! WIFI_ON ))
				if [ $WIFI_ON -eq 1 ] && [ $_WIFI_ON -eq 0 ]; then
					_WIFI_ON=1
					LD_PRELOAD= ./wifion.sh > /dev/null 2>&1 &
				fi
				break
			fi
		elif [ $KEY -eq 97 ]; then  # 97 = SELECT
			./wifisetup.sh
			break
		elif [ $KEY -eq 29 ]; then  # 29 = B
			if [ $WIFI_ON -eq 0 ] && [ $_WIFI_ON -eq 1 ]; then
				LD_PRELOAD= ./wifioff.sh > /dev/null 2>&1 &
			fi
			exit 0
		fi
	done
done
