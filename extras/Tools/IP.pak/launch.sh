#!/bin/sh

DIR=$(dirname "$0")
cd "$DIR"

ipvalid() {
	if expr "$1" : '[0-9][0-9]*\.[0-9][0-9]*\.[0-9][0-9]*\.[0-9][0-9]*$' >/dev/null; then
		return 0
	fi
	return 1
}

sayip() {
	IP=$(ip route get 255.255.255.255 | awk '{print $NF;exit}')
	if ipvalid "$IP"; then
		EXT_IP=$(nslookup myip.opendns.com resolver4.opendns.com | awk '/Address 1:/{i++}i==2{print $3;exit}')
		show confirm.png
		say "Local IP: '$IP'"$'\n'"Public IP: '$EXT_IP'"
	else
		show confirm.png
		say "Not connected"
	fi
}

show confirm.png
say "Retrieving ..."
sayip
sleep 0.1

while confirm; do
	show confirm.png
	say "Retrieving ..."
	sayip
	sleep 0.1
done
