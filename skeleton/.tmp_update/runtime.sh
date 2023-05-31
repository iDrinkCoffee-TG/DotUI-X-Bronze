#!/bin/sh

# install
if [ -d "/mnt/SDCARD/miyoo354" ]; then
	rm -rf /tmp/runtime.sh.old
	mv /mnt/SDCARD/.tmp_update/runtime.sh /tmp/runtime.sh.old
	exit 0
fi

# or launch
LAUNCH_PATH="/mnt/SDCARD/.system/paks/MiniUI.pak/launch.sh"
if [ -f "$LAUNCH_PATH" ]; then
	"$LAUNCH_PATH"
fi

while true; do
	reboot
	sleep 10
done
