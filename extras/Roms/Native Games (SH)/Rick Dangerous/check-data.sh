#!/bin/sh

DATA_URL="https://github.com/libretro/xrick-libretro/raw/master/data.zip"

zipvalid() {
	if [ "$(hexdump -n 4 -e '1/4 "%u"' "$1" 2> /dev/null)" = "67324752" ]; then
		return 0
	fi
	return 1
}

cd "$(dirname "$0")"
if [ -f ./data.zip ]; then
	exit 0
fi

if [ -z "$(curl --version 2> /dev/null)" ] || ! (ip route get 1.1.1.1); then
	show okay.png
	say "Rick Dangerous data missing !"$'\n\n'"Please connect to internet to download"$'\n'"the data or see readme.txt in the"$'\n'"Rick Dangerous folder for manual"$'\n'"installation instructions."$'\n'
	confirm only
	exit 1
fi
show confirm.png
say "Rick Dangerous data missing !"$'\n\n'"Do you want to download the"$'\n'"required data files now?"$'\n'
if ! confirm; then exit 1; fi

progressui &
PROG_PID=$!
sleep 0.5

progress 0 "Checking for free space ..."

sync
if ! [ "$(df -m /mnt/SDCARD/ | tail -1 | awk '{print $(NF-2);exit}')" -gt 50 ] 2>/dev/null; then
	progress quit
	wait $PROG_PID
	show okay.png
	say "Not enough free space !"$'\n\n'"50MB of free space is"$'\n'"required to proceed."$'\n'
	confirm only
	exit 0
fi


progress 50 "Downloading data ..."
curl --silent -f --connect-timeout 30 -m 600 -L -k -o data.zip "$DATA_URL" && \
zipvalid "data.zip"
if [ $? -ne 0 ] || [ ! -f ./data.zip ]; then
	rm -rf data.zip
	sync
	progress quit
	wait $PROG_PID
	show okay.png
	say "Data download failed !"$'\n\n'"Please see readme.txt in the"$'\n'"Rick Dangerous folder for manual"$'\n'"installation instructions."$'\n'
	confirm only
	exit 1
fi

sync
progress 100 "Launching game ..."
sleep 2
progress quit
wait $PROG_PID
exit 0
