#!/bin/sh

rm -f "$USERDATA_PATH/.wifi/wifi_on.txt"
killall telnetd > /dev/null 2>&1 &
killall ftpd > /dev/null 2>&1 &
killall tcpsvd > /dev/null 2>&1 &
killall dropbear > /dev/null 2>&1 &
killall wpa_supplicant > /dev/null 2>&1 &
killall udhcpc > /dev/null 2>&1 &
ifconfig wlan0 down
/customer/app/axp_test wifioff
