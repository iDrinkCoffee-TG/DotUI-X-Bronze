#!/bin/sh

DIR=$(dirname "$0")
cd "$DIR"

mkdir -p "$USERDATA_PATH/.wifi"

show change.png
if [ -f "$USERDATA_PATH/.wifi/telnet_on.txt" ]; then
	say "Telnet: Enabled"
else
	say "Telnet: Disabled"
fi

while confirm; do
	show change.png
	if [ -f "$USERDATA_PATH/.wifi/telnet_on.txt" ]; then
		rm -f "$USERDATA_PATH/.wifi/telnet_on.txt"
		LD_PRELOAD= killall telnetd > /dev/null 2>&1
		say "Telnet: Disabled"
	else
		touch "$USERDATA_PATH/.wifi/telnet_on.txt"
		if [ -f "$USERDATA_PATH/.wifi/wifi_on.txt" ]; then
			(cd / && LD_PRELOAD= telnetd -l sh)
		fi
		say "Telnet: Enabled"
	fi
done
