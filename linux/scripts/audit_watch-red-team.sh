#!/bin/bash
# Author: Noah Tongate @Ap3x
# Description:
#  Watchs for any Red Team connections and logs it
# Usage:
# ./<SCRIPT NAME>

ss -tupn | grep -v -i "^Netid" > logconnect.log
while true; do
	sleep 2s
	ss -tupn | grep -v -i "^Netid" > temp2.log
	cat logconnect.log | grep -ie "^tcp" -ie "^udp" > temp1.log
	diff -b temp1.log temp2.log | grep ">" | grep -e tcp -e udp | sed 's/^..//' >> logconnect.log
	if [[ $(diff -b temp1.log temp2.log | grep ">" | grep -e tcp -e udp | sed 's/^..//')  ]]; then
		date >> logconnect.log
	fi
done
rm temp1.log
rm temp2.log
