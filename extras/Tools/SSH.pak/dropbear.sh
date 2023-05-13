#!/bin/sh

DIR=$(dirname "$0")
cd "$DIR"
BASEDIR="$PWD"
mkdir -p "$USERDATA_PATH/.ssh"

SSH_PASS=$(cat "$USERDATA_PATH/.ssh/ssh_pass.txt" | head -1)
if [ -z "$SSH_PASS" ]; then
	(cd / && "$BASEDIR/dropbear" -R -B) > /dev/null 2>&1 &
else
	(cd / && "$BASEDIR/dropbear" -R -Y "$SSH_PASS") > /dev/null 2>&1 &
fi
