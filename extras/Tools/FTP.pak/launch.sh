#!/bin/sh

DIR=$(dirname "$0")
cd "$DIR"

mkdir -p "$USERDATA_PATH/.wifi"

show toggle.png
if [ -f "$USERDATA_PATH/.wifi/ftp_on.txt" ]; then
	say "FTP: Enabled"
else
	say "FTP: Disabled"
fi

while confirm; do
	show toggle.png
	if [ -f "$USERDATA_PATH/.wifi/ftp_on.txt" ]; then
		rm -f "$USERDATA_PATH/.wifi/ftp_on.txt"
		LD_PRELOAD= killall ftpd > /dev/null 2>&1
		LD_PRELOAD= killall tcpsvd > /dev/null 2>&1
		say "FTP: Disabled"
	else
		touch "$USERDATA_PATH/.wifi/ftp_on.txt"
		if [ -f "$USERDATA_PATH/.wifi/wifi_on.txt" ]; then
			LD_PRELOAD= tcpsvd -E 0.0.0.0 21 ftpd -w /mnt/SDCARD > /dev/null 2>&1 &
		fi
		say "FTP: Enabled"
	fi
done
