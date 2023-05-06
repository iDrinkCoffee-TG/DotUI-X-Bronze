#!/bin/sh

DIR=$(dirname "$0")
cd "$DIR"

mkdir -p "$USERDATA_PATH/.wifi"

CONFIRM=0
WIFI_SSID="$(keyboard "Enter WiFi network name:" 32)"

if [ $? -eq 0 ] && [ ! -z "$WIFI_SSID" ]; then
	show confirm.png
	say "WiFi network name set:"$'\n'"${WIFI_SSID:0:16}"$'\n'"${WIFI_SSID:17}"
	if confirm; then
		CONFIRM=1
	fi
fi

if [ $CONFIRM == 0 ]; then 
	show okay.png
	say "WiFi network settings were not changed"$'\n'"Exiting setup ..."
	sleep 3
	exit 0
fi

CONFIRM=0
WIFI_PASS="$(keyboard "Enter WiFi network pass:" 63)"

if [ $? -eq 0 ]; then
	show confirm.png
	if [ ! -z "$WIFI_PASS" ]; then
		say "WiFi network password set:"$'\n'"${WIFI_PASS:0:16}"$'\n'"${WIFI_PASS:17:16}"$'\n'"${WIFI_PASS:33:16}"$'\n'"${WIFI_PASS:48}"
	else
		say "WiFi network password set to empty"
	fi
	if confirm; then
		CONFIRM=1
	fi
fi

if [ $CONFIRM == 0 ]; then 
	show okay.png
	say "WiFi network settings were not changed"$'\n'"Exiting setup ..."
	sleep 3
	exit 0
fi

echo "ctrl_interface=/var/run/wpa_supplicant" > /appconfigs/wpa_supplicant.conf
echo "update_config=1" >> /appconfigs/wpa_supplicant.conf
echo $'\n'"network={" >> /appconfigs/wpa_supplicant.conf
echo $'\tssid="'"$WIFI_SSID"$'"' >> /appconfigs/wpa_supplicant.conf
if [ ! -z "$WIFI_PASS" ]; then
	echo $'\tpsk="'"$WIFI_PASS"$'"' >> /appconfigs/wpa_supplicant.conf
else
	echo $'\t'"key_mgmt=NONE" >> /appconfigs/wpa_supplicant.conf
fi
echo "}" >> /appconfigs/wpa_supplicant.conf

show okay.png
say "WiFi network settings saved"$'\n'"Exiting setup ..."
sleep 3
exit 0
