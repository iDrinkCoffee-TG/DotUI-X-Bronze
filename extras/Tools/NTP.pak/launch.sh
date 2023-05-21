#!/bin/sh

DIR=$(dirname "$0")
cd "$DIR"

mkdir -p "$USERDATA_PATH/.wifi"

show change.png
if [ -f "$USERDATA_PATH/.wifi/ntp_on.txt" ]; then
	say "NTP (Time Sync): Enabled"
else
	say "NTP (Time Sync): Disabled"
fi

while confirm; do
	show change.png
	if [ -f "$USERDATA_PATH/.wifi/ntp_on.txt" ]; then
		rm -f "$USERDATA_PATH/.wifi/ntp_on.txt"
		LD_PRELOAD= killall ntpd > /dev/null 2>&1
		say "NTP (Time Sync): Disabled"
	else
		touch "$USERDATA_PATH/.wifi/ntp_on.txt"
		if [ -f "$USERDATA_PATH/.wifi/wifi_on.txt" ]; then
			LD_PRELOAD= ntpd -p 216.239.35.12 -S "/sbin/hwclock -w -u" > /dev/null 2>&1 &
		fi
		say "NTP (Time Sync): Enabled"
	fi
done
