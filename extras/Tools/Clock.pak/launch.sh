#!/bin/sh

APP_EXE="./clock"
PERF_LEVEL=ondemand

###############################

APP_TAG=$(basename "$(dirname "$0")" .pak)
DIR="$(dirname "$0")"
HOME="$USERDATA_PATH"
cd "$DIR"
echo "$PERF_LEVEL" > "$CPU_PATH"
"$APP_EXE" &> "$LOGS_PATH/$APP_TAG.txt"
