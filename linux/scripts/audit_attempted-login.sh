#!/bin/bash
# Author: Noah Tongate @Ap3x
# Description:
# WIP
# Usage:
# ./<SCRIPT NAME>

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

# Separator
x=0; while [ $x -lt $(tput cols) ];do echo -n '#'; let x=$x+1; done; echo

# Depending on OS
#TODO
echo -e "${GREEN}Attempted Logins:  ${NC}"
