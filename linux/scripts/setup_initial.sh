#!/bin/bash
# Author: Noah Tongate @Ap3x
# Description:
# Gathers System Info
# Usage:
# ./<SCRIPT NAME>

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

# Change password
passwd
passwd root

# Remove access to crons from every user except root
awk -F: '{ print $1 }' /etc/passwd | tail -n+2 >> /etc/cron.deny

# Clear auth keys for all users
for user_d in /home/* ; do
    if [ -d "$user_d/.ssh" ]; then   
        if [ -d "$user_d/.ssh/authorized_keys" ];
            : > "$user_d/.ssh/authorized_keys"
        fi
    fi 
done

# System Name
echo -n -e "${GREEN}System Name: ${NC}"; cat /etc/hostname
echo -n -e "${GREEN}Operating System Info: ${NC}"; cat /etc/os-release | grep PRETTY_NAME | cut -d '=' -f2
echo  -e "${GREEN}IP Address: ${NC}"; ip a ; echo -e "\n\n"
echo -e "${GREEN}Accounts/Users: ${NC}"; cat /etc/passwd | cut -d ':' -f1
echo -e "${GREEN}Running Services: ${NC}"; service --status-all | grep '+'
echo -e "${GREEN}Open Ports: ${NC}"; echo; ss -tulpn
echo -e "${GREEN}Open Ports: ${NC}"; echo; ps aux

# Check Firewalls
sudo apt install ufw -y
sudo yum install ufw -y
ufw status

# Stop SSH 
systemctl stop ssh
# Stop ssh
/etc/init.d/ssh stop

cp ../ssh-banner /etc/ssh/.


