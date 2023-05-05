#!/bin/sh

DIR=$(dirname "$0")
cd "$DIR"

mkdir -p "$USERDATA_PATH/.wifi"

show confirm.png
if [ -f "$USERDATA_PATH/.wifi/wifi_on.txt" ]; then
	WIFI_ON=1
	say "WiFi: Enabled"
else
	WIFI_ON=0
	say "WiFi: Disabled"
fi

while confirm; do
	show confirm.png
	if [ $WIFI_ON == 1 ]; then
		WIFI_ON=0
		say "WiFi: Disabled"
	else
		WIFI_ON=1
		say "WiFi: Enabled"
	fi
	sleep 1
done

if [ -f "$USERDATA_PATH/.wifi/wifi_on.txt" ]; then
	if [ $WIFI_ON == 0 ]; then
		LD_PRELOAD= ./wifioff.sh > /dev/null 2>&1 &
	fi
else
	if [ $WIFI_ON == 1 ] && [ -f /mnt/SDCARD/.system/paks/WiFi.pak/8188fu.ko ] && [ -f /appconfigs/wpa_supplicant.conf ]; then
		LD_PRELOAD= ./wifion.sh > /dev/null 2>&1 &
	fi
fi
