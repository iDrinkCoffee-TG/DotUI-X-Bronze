#!/bin/sh

PERF_LEVEL=performance

###############################

DIR="$(dirname "$0")"
HOME="$USERDATA_PATH"

cd "$DIR"
if [ -f data.zip ]; then
	warn
	echo "$PERF_LEVEL" > "$CPU_PATH"
	./vvvvvv
else
	show "okay.png"
	say "Missing data.zip!"$'\n\n'"Please see readme.txt"$'\n'"in the VVVVVV folder"$'\n'"on your SD card."$'\n'
	confirm only
fi
