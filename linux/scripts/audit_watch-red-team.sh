#!/bin/bash
# Author: Noah Tongate @Ap3x
# Description:
#  Watchs for any Red Team connections and logs it
# Usage:
# ./<SCRIPT NAME>

LOGFILE="/var/log/logconnections.log"
TEMPFILE1="/tmp/tmp1.log"
TEMPFILE2="/tmp/tmp2.log"

ss -tupn | grep -v -i "^Netid" > $LOGFILE
while true; do
	sleep 2s
	ss -tupn | grep -v -i "^Netid" > temp2.log
	cat logconnect.log | grep -ie "^tcp" -ie "^udp" > $TEMPFILE1
	diff -b $TEMPFILE1 $TEMPFILE2 | grep ">" | grep -e tcp -e udp | sed 's/^..//' >> $LOGFILE
	if [[ $(diff -b $TEMPFILE1 $TEMPFILE2 | grep ">" | grep -e tcp -e udp | sed 's/^..//')  ]]; then
		date >> $LOGFILE
	fi
done
rm $TEMPFILE1
rm $TEMPFILE2
