#!/bin/bash

GREEN='\033[0;32m'
RED='\033[0;31m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m'

pause() {
    echo
    read -p "Press Enter to continue..."
}

while true
do
    clear

    echo -e "${GREEN}====================================================${NC}"
    echo -e "${GREEN}        LINUX SERVER HEALTH MONITOR v1.0${NC}"
    echo -e "${GREEN}====================================================${NC}"
    echo
    echo "1. System Information"
    echo "2. CPU Usage"
    echo "3. Memory Usage"
    echo "4. Disk Usage"
    echo "5. Network Information"
    echo "6. Logged-in Users"
    echo "7. Running Processes"
    echo "8. Generate Health Report"
    echo "9. Exit"
    echo

    read -p "Enter your choice: " choice

    case $choice in

    1)
        clear
        echo -e "${CYAN}========== SYSTEM INFORMATION ==========${NC}"
        echo
        echo "Hostname       : $(hostname)"
        echo "Current User   : $(whoami)"
        echo "Date           : $(date)"
        echo

        if command -v hostnamectl &>/dev/null; then
            hostnamectl
        else
            echo "Operating System : $(uname -o 2>/dev/null)"
            echo "Kernel Version   : $(uname -r)"
            echo "Architecture     : $(uname -m)"
        fi

        echo
        echo "System Uptime:"
        uptime
        pause
        ;;

    2)
        clear
        echo -e "${CYAN}============= CPU USAGE =============${NC}"
        echo
        top -bn1 | grep "Cpu"
        echo
        echo "Load Average:"
        uptime
        pause
        ;;

    3)
        clear
        echo -e "${CYAN}=========== MEMORY USAGE ===========${NC}"
        echo
        free -h
        pause
        ;;

    4)
        clear
        echo -e "${CYAN}============ DISK USAGE ============${NC}"
        echo
        df -h
        pause
        ;;

    5)
        clear
        echo -e "${CYAN}========= NETWORK INFORMATION =========${NC}"
        echo

        if command -v ip &>/dev/null; then
            echo "IP Address:"
            hostname -I
            echo
            echo "Interfaces:"
            ip -br addr
            echo
            echo "Routing Table:"
            ip route
        else
            echo "Network utilities not available."
        fi

        pause
        ;;

    6)
        clear
        echo -e "${CYAN}========== LOGGED-IN USERS ==========${NC}"
        echo
        who
        echo
        echo "Detailed Session Information:"
        w
        pause
        ;;

    7)
        clear
        echo -e "${CYAN}========= RUNNING PROCESSES =========${NC}"
        echo

        echo "Top 5 CPU Consuming Processes"
        ps aux --sort=-%cpu | head -6

        echo
        echo "Top 5 Memory Consuming Processes"
        ps aux --sort=-%mem | head -6

        pause
        ;;

    8)
        clear

        REPORT="health_report_$(date +%Y%m%d_%H%M%S).txt"

        {
        echo "======================================="
        echo "      LINUX SERVER HEALTH REPORT"
        echo "======================================="
        echo
        echo "Generated On : $(date)"
        echo "Hostname     : $(hostname)"
        echo "User         : $(whoami)"
        echo

        echo "--------------- CPU ----------------"
        top -bn1 | grep "Cpu"

        echo
        echo "------------- MEMORY ---------------"
        free -h

        echo
        echo "-------------- DISK ----------------"
        df -h

        echo
        echo "------------- NETWORK --------------"
        hostname -I 2>/dev/null

        echo
        echo "---------- LOGGED USERS ------------"
        who

        echo
        echo "--------- TOP CPU PROCESS ----------"
        ps aux --sort=-%cpu | head -6

        echo
        echo "------- TOP MEMORY PROCESS ---------"
        ps aux --sort=-%mem | head -6

        echo
        echo "------------- UPTIME ---------------"
        uptime

        } > "$REPORT"

        echo -e "${GREEN}✔ Health Report Generated Successfully${NC}"
        echo
        echo "Saved as:"
        echo "$REPORT"

        pause
        ;;

    9)
        clear
        echo -e "${GREEN}Thank you for using Linux Server Health Monitor.${NC}"
        exit
        ;;

    *)
        echo -e "${RED}Invalid Choice! Please try again.${NC}"
        sleep 2
        ;;

    esac

done
