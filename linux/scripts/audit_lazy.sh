#!/bin/bash
# Description:
#  Audit the system and common checks for linux
# Usage:
# ./<SCRIPT NAME>

#audit users
cat /etc/passwd | awk –F: ‘($4 == 0) { print $1 }’

#makes a list of users to change, just add another user here
adminlist=("shutdown" "sync" "halt" "operator")
for adminusers in ${adminlist[@]}
do
#change the password
echo "password" | passwd --stdin $adminusers
done

#replace <otheruser> with any users.
otherlist=("nobody" "gopher" "sshd" "<otherusers>")
for otherusers in ${otherlist[@]}
do
#change the password
echo "password" | passwd --stdin $otherusers
done

Linux Hardening Script Stuff 

clt-alt-T ← command line (also circle thing, search for terminal) 

sudo !! ← should add a sudo in front of a command if you forget it 

sudo apt-get update | sudo apt-get upgrade | y 

 

sudo passwd [user] 

passwd ← change password of current user (definitely need to change root, sysadmin) 

sudo groupdel [group name] 

 
 

sudo su ← change to root 

 
 

/etc/apt cat sources.list ←- Print this out on ours 

/etc/apt cat sudoers ←-check for new sudoers 

/var/log ←-log files are here 

faillog ← will list all failed logins 

sudo apt-get install fail2ban ←-research this 

ufw ← uncomplicated firewall, manage ip tables 

auth.log (PAM modules, md5 hash = ssh without auth) 

 
 

Skillet thing on docker?  

Get request in command prompt to get github script 

ssh admin@172.20.242.150 ← log into PA from CMDline 

 
 

cp [old file] [new file] 

Fail2Ban  

jail.local 

findtime = 600 

maxretry = 2 

sudo fail2ban-client start/reload/stop 

Sudo fail2ban-client status sshd 

 
 
 

ufw status 

ufw enable 

 
 

systemctl start sshd 

 

Sudo netstat -lntp 

Sudo service cups stop <-- stops that weird cups thing on port 631 

 

Wget  

 

UFW https://help.ubuntu.com/community/UFW  

Sudo ufw enable 

Sudo ufw status verbose 

 

Deny incoming 

sudo ufw default deny incoming 

 

Deny outgoing 

sudo ufw default deny outgoing 

 

Allowing outgoing to PA, SSH/HTTPS 

Sudo ufw allow out to 172.20.242.150 port 22 

Sudo ufw allow out to 172.20.242.150 port 443 

 

Splunk  

Sudo ufw allow out to 172.20.241.20 port # proto [tcp/udp] 

Sudo ufw allow out to 172.20.241.20 port 27872 proto tcp 

Sudo ufw allow out to 172.20.241.20 port 8089 proto tcp 

Sudo ufw allow in from 172.20.241.20 port 8089 proto tcp 

Sudo ufw allow out to 172.20.241.20 port 514 proto udp 

 

 

Ntp to ntp server 

Sudo ufw allow out to 172.20.242.10[or.200] port 123 

 

IF I am a DNS server 

Allow port 53 both in and out 

sudo ufw allow 53 

sudo ufw allow out 53 

 

Sudo History 

/etc/crontab 

/var/spool/anacron 

/var/backups 

IP: 10.8.8.8 

Config.inc.php 

/usr/share/popularity-contest 

/etc/popularity-contest.conf 

/var/log/popularity-contest 

Logrotate in cron.daily crontab 