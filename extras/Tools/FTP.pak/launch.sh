#!/bin/sh

DIR=$(dirname "$0")
cd "$DIR"

mkdir -p "$USERDATA_PATH/.wifi"

show confirm.png
if [ -f "$USERDATA_PATH/.wifi/ftp_on.txt" ]; then
	say "FTP: Enabled"
else
	say "FTP: Disabled"
fi

while confirm; do
	show confirm.png
	if [ -f "$USERDATA_PATH/.wifi/ftp_on.txt" ]; then
		rm -f "$USERDATA_PATH/.wifi/ftp_on.txt"
		say "FTP: ..."
		LD_PRELOAD= killall ftpd > /dev/null 2>&1
		LD_PRELOAD= killall tcpsvd > /dev/null 2>&1
		show confirm.png
		say "FTP: Disabled"
	else
		touch "$USERDATA_PATH/.wifi/ftp_on.txt"
		LD_PRELOAD= tcpsvd -E 0.0.0.0 21 ftpd -w /mnt/SDCARD > /dev/null 2>&1 &
		say "FTP: Enabled"
	fi
	sleep 1
done
