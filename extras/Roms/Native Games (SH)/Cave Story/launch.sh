#!/bin/sh

PERF_LEVEL=performance

###############################

DIR="$(dirname "$0")"
HOME="$USERDATA_PATH"

cd "$DIR"
echo "$PERF_LEVEL" > "$CPU_PATH"
if ./check-data.sh; then
	cd "$HOME"
	picoarch "$DIR/nxengine_libretro.so" "$DIR/CaveStory/Doukutsu.exe"
fi
