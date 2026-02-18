#!/usr/bin/env bash

MAC="${1:-$headphones_mac}"

echo "--- Deleting $MAC... ---"
bluetoothctl remove "$MAC"

echo "--- Restarting bluetooth... ---"
sudo systemctl restart bluetooth
sleep 2

echo "--- Enabling adapter and scan... ---"
bluetoothctl power on
bluetoothctl agent on

echo "--- Scanning for 15 sec... Switch headphones to pair mode. ---"
bluetoothctl scan on &
SCAN_PID=$!
sleep 15
kill $SCAN_PID
bluetoothctl scan off

echo "--- Trying to connect $MAC... ---"
bluetoothctl pair "$MAC"   && echo "Paired OK"  || echo "Pair FAILED"
bluetoothctl trust "$MAC"  && echo "Trusted OK" || echo "Trust FAILED"
bluetoothctl connect "$MAC" && echo "Connected OK" || echo "Connect FAILED"
