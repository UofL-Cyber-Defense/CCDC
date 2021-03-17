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

# System Name
echo -n -e "${GREEN}System Name: ${NC}"; cat /etc/hostname
echo -n -e "${GREEN}Operating System Info: ${NC}"; cat /etc/os-release | grep PRETTY_NAME | cut -d '=' -f2
echo  -e "${GREEN}IP Address: ${NC}"; ip a ; echo -e "\n\n"
echo -e "${GREEN}Accounts/Users: ${NC}"; cat /etc/passwd | cut -d ':' -f1
echo -e "${GREEN}Running Services: ${NC}"; service --status-all | grep '+'
echo -e "${GREEN}Open Ports: ${NC}"; ss -tulpn
