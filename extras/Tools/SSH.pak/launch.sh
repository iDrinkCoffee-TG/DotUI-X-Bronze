#!/bin/sh

DIR=$(dirname "$0")
cd "$DIR"

mkdir -p "$USERDATA_PATH/.wifi"
mkdir -p "$USERDATA_PATH/.ssh"

if [ ! -f "$DIR/dropbear" ]; then
	rm -f "$USERDATA_PATH/.wifi/ssh_on.txt"
	show okay.png
	say "A component is missing (dropbear)!"$'\n'"Please reinstall SSH.pak."
	confirm any
	exit 0
fi

while :; do
	show ./ssh.png
	if [ -f "$USERDATA_PATH/.wifi/ssh_on.txt" ]; then
		if [ -z "$(cat "$USERDATA_PATH/.ssh/ssh_pass.txt" | head -1)" ]; then
			say "SSH: Enabled"$'\n'"Password: No"
		else
			say "SSH: Enabled"$'\n'"Password: Yes"
		fi
	elif [ -z "$(cat "$USERDATA_PATH/.ssh/ssh_pass.txt" | head -1)" ]; then
		say "SSH: Disabled"$'\n'"Password: No"
	else
		say "SSH: Disabled"$'\n'"Password: Yes"
	fi
	while :; do
		confirm any
		KEY=$?
		if [ $KEY -eq 57 ]; then  # 57 = A
			if [ -f "$USERDATA_PATH/.wifi/ssh_on.txt" ]; then
				rm -f "$USERDATA_PATH/.wifi/ssh_on.txt"
				LD_PRELOAD= killall dropbear > /dev/null 2>&1
			else
				touch "$USERDATA_PATH/.wifi/ssh_on.txt"
				if [ -f "$USERDATA_PATH/.wifi/wifi_on.txt" ]; then
					LD_PRELOAD= ./dropbear.sh > /dev/null 2>&1 &
				fi
			fi
			break
		elif [ $KEY -eq 97 ]; then  # 97 = SELECT
			SSH_PASS="$(keyboard "Enter master password:" 63)"
			if [ $? -eq 0 ]; then
				echo -n "$SSH_PASS" > "$USERDATA_PATH/.ssh/ssh_pass.txt"
				if [ -f "$USERDATA_PATH/.wifi/ssh_on.txt" ] && [ -f "$USERDATA_PATH/.wifi/wifi_on.txt" ]; then
					(LD_PRELOAD= killall dropbear;LD_PRELOAD= ./dropbear.sh) > /dev/null 2>&1 &
				fi
			fi
			break
		elif [ $KEY -eq 29 ]; then  # 29 = B
			exit 0
		fi
	done
done
