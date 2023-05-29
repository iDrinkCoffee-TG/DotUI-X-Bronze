#!/bin/sh

PERF_LEVEL=performance

###############################

DIR="$(dirname "$0")"
HOME="$USERDATA_PATH"

cd "$DIR"
echo "$PERF_LEVEL" > "$CPU_PATH"
if ./check-data.sh; then
	warn
	./vvvvvv
fi
