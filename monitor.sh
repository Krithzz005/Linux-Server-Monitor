#!/bin/bash

clear

echo "====================================="
echo "      Linux Server Health Monitor"
echo "====================================="

echo ""
echo "Hostname : $(hostname)"
echo "User     : $(whoami)"
echo "Date     : $(date)"

echo ""
echo "System Uptime"
uptime

echo ""
echo "-------------------------------------"
echo "CPU Usage"
top -bn1 | grep "Cpu"

echo ""
echo "-------------------------------------"
echo "Memory Usage"
free -h

echo ""
echo "-------------------------------------"
echo "Disk Usage"
df -h

echo ""
echo "-------------------------------------"
echo "Logged in Users"
who

echo ""
echo "-------------------------------------"
echo "Top 5 Memory Consuming Processes"
ps aux --sort=-%mem | head -6

echo ""
echo "-------------------------------------"
echo "Top 5 CPU Consuming Processes"
ps aux --sort=-%cpu | head -6


GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${GREEN}Linux Server Health Monitor${NC}"

read choice

case $choice in

1)
hostnamectl
;;

2)
top -bn1
;;

3)
free -h
;;

4)
df -h
;;

5)
ps aux
;;

6)
who
;;

7)
exit
;;

esac
