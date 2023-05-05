#!/bin/sh

DIR=$(dirname "$0")
cd "$DIR"

mkdir -p "$USERDATA_PATH/.wifi"

show confirm.png
if [ -f "$USERDATA_PATH/.wifi/telnet_on.txt" ]; then
	say "Telnet: Enabled"
else
	say "Telnet: Disabled"
fi

while confirm; do
	show confirm.png
	if [ -f "$USERDATA_PATH/.wifi/telnet_on.txt" ]; then
		rm -f "$USERDATA_PATH/.wifi/telnet_on.txt"
		say "Telnet: ..."
		LD_PRELOAD= killall telnetd > /dev/null 2>&1
		show confirm.png
		say "Telnet: Disabled"
	else
		touch "$USERDATA_PATH/.wifi/telnet_on.txt"
		(cd / && LD_PRELOAD= telnetd -l sh)
		say "Telnet: Enabled"
	fi
	sleep 1
done
