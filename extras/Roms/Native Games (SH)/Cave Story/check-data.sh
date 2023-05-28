#!/bin/sh

DATA_URL="https://www.cavestory.org/downloads/cavestoryen.zip"

zipvalid() {
	if [ "$(hexdump -n 4 -e '1/4 "%u"' "$1" 2> /dev/null)" = "67324752" ]; then
		return 0
	fi
	return 1
}

cd "$(dirname "$0")"
if [ -f ./CaveStory/Doukutsu.exe ] && [ -d ./CaveStory/data ]; then
	exit 0
fi

DOWNLOAD=0
if [ ! -f ./cavestoryen.zip ]; then
	if [ -z "$(curl --version 2> /dev/null)" ] || [ -z "$(miniunz 2> /dev/null)" ] || ! (ip route get 1.1.1.1); then
		show okay.png
		say "Cave Story data missing !"$'\n\n'"Please connect to internet to download"$'\n'"the data or see readme.txt in the"$'\n'"Cave Story folder for manual"$'\n'"installation instructions."$'\n'
		confirm only
		exit 1
	fi
	show confirm.png
	say "Cave Story data missing !"$'\n\n'"Do you want to download the"$'\n'"required data files now?"$'\n'
	if ! confirm; then exit 1; fi
	DOWNLOAD=1
fi

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

if [ "$DOWNLOAD" = "1" ]; then
	progress 33 "Downloading data ..."
	curl --silent -f --connect-timeout 30 -m 600 -L -k -o cavestoryen.zip "$DATA_URL" && \
	zipvalid "cavestoryen.zip" && 
	if [ $? -ne 0 ] || [ ! -f cavestoryen.zip ]; then
		rm -rf cavestoryen.zip
		sync
		progress quit
		wait $PROG_PID
		show okay.png
		say "Data download failed !"$'\n\n'"Please see readme.txt in the"$'\n'"Cave Story folder for manual"$'\n'"installation instructions."$'\n'
		confirm only
		exit 1
	fi
	progress 66 "Extracting data ..."
else
	progress 50 "Extracting data ..."
fi

miniunz -x -o "cavestoryen.zip"
if [ $? -ne 0 ] || [ ! -f ./CaveStory/Doukutsu.exe ] || [ ! -d ./CaveStory/data ]; then
	rm -rf CaveStory
	rm -rf cavestoryen.zip
	sync
	progress quit
	wait $PROG_PID
	show okay.png
	say "Data extraction failed !"$'\n\n'"Please see readme.txt in the"$'\n'"Cave Story folder for manual"$'\n'"installation instructions."$'\n'
	confirm only
	exit 1
fi

rm -rf cavestoryen.zip
sync
progress 100 "Launching game ..."
sleep 2
progress quit
wait $PROG_PID
exit 0
