#!/bin/bash

# Color Definitions
RED='\033[38;2;231;76;60m'      # Red
BLUE='\033[38;5;32m'            # Blue
GREEN='\033[38;5;82m'           # Green
YELLOW='\033[38;5;226m'         # Yellow
CYAN='\033[38;5;51m'            # Cyan
MAGENTA='\033[38;5;171m'        # Magenta
NC='\033[0m'                    # No Color

# Functions for Submenus
network_optimization_menu() {
    while true; do
        clear
        echo -e "${GREEN}== Network Optimization ==${NC}"
        echo -e "1) Install Hybla"
        echo -e "2) Install BBR"
        echo -e "3) Delete Optimize (BBR and Hybla)"
        echo -e "4) Create Swap"
        echo -e "5) Create ZRAM"
        echo -e "6) MTU Finder + Auto Set"
        echo -e "7) MTU Finder"
        echo -e "0) Back to Main Menu"
        read -p "Enter your choice: " choice
        case $choice in
            1) echo "Running Hybla script..." ;;
            2) echo "Running BBR script..." ;;
            3) echo "Running Uninstall script..." ;;
            4) echo "Running Swap script..." ;;
            5) echo "Running ZRAM script..." ;;
            6) echo "Running MTU Finder + Auto Set script..." ;;
            7) echo "Running MTU Finder script..." ;;
            0) return ;;
            *) echo "Invalid choice." ; sleep 2 ;;
        esac
    done
}

server_management_menu() {
    while true; do
        clear
        echo -e "${BLUE}== Server & Network Management ==${NC}"
        echo -e "1) Block and Unblock Server Ping"
        echo -e "2) Block Torrent List"
        echo -e "3) Change Server DNS"
        echo -e "4) Change SSH Port"
        echo -e "5) Block and Unblock Private Network"
        echo -e "6) Block and Unblock Iranian ISP"
        echo -e "7) Install mikrotik on Ubuntu"
        echo -e "8) Install Monitoring System (Cockpit)"
        echo -e "0) Back to Main Menu"
        read -p "Enter your choice: " choice
        case $choice in
            1) echo "Running Server Ping Blocker..." ;;
            2) echo "Running Block Torrent List..." ;;
            3) echo "Running Server DNS Changer..." ;;
            4) echo "Running SSH Port Changer..." ;;
            5) echo "Running Private Network Blocker..." ;;
            6) echo "Running Iranian ISP Blocker..." ;;
            7) echo "Running Mikrotik Installer..." ;;
            8) echo "Installing Monitoring System..." ;;
            0) return ;;
            *) echo "Invalid choice." ; sleep 2 ;;
        esac
    done
}

security_menu() {
    while true; do
        clear
        echo -e "${RED}== Security ==${NC}"
        echo -e "1) Install Fail2ban for SSH Security"
        echo -e "2) Block and Unblock All SpeedTest Websites"
        echo -e "0) Back to Main Menu"
        read -p "Enter your choice: " choice
        case $choice in
            1) echo "Installing Fail2ban..." ;;
            2) echo "Running SpeedTest Blocker..." ;;
            0) return ;;
            *) echo "Invalid choice." ; sleep 2 ;;
        esac
    done
}

system_maintenance_menu() {
    while true; do
        clear
        echo -e "${MAGENTA}== System Maintenance ==${NC}"
        echo -e "1) Fix WhatsApp Data and Time"
        echo -e "2) Disable IPv6"
        echo -e "0) Back to Main Menu"
        read -p "Enter your choice: " choice
        case $choice in
            1) echo "Fixing WhatsApp Data and Time..." ;;
            2) echo "Disabling IPv6..." ;;
            0) return ;;
            *) echo "Invalid choice." ; sleep 2 ;;
        esac
    done
}

# Main Menu
while true; do
    clear
	echo -e "${CYAN}+======================================================================+${NC}"
	echo -e	"${RED}##    ## ######## ########  #######  ########  ######## #### ##     ## ${NC}"
	echo -e	"${RED}###   ## ##          ##    ##     ## ##     ##    ##     ##   ##   ##  ${NC}"
	echo -e	"${RED}####  ## ##          ##    ##     ## ##     ##    ##     ##    ## ##   ${NC}"
	echo -e	"${RED}## ## ## ######      ##    ##     ## ########     ##     ##     ###    ${NC}"
	echo -e	"${RED}##  #### ##          ##    ##     ## ##           ##     ##    ## ##   ${NC}"
	echo -e	"${RED}##   ### ##          ##    ##     ## ##           ##     ##   ##   ##  ${NC}"
	echo -e	"${RED}##    ## ########    ##     #######  ##           ##    #### ##     ## ${NC}"
	echo -e "${CYAN}+======================================================================+${NC}"
    echo -e "|  Telegram Channel : ${MAGENTA}@AminiDev ${NC}|  Version : ${GREEN} 4.0.0${NC} "
	echo -e "${CYAN}+======================================================================+${NC}"
    echo -e "${CYAN}== Main Menu ==${NC}"
    echo -e "1) Network Optimization"
    echo -e "2) Server & Network Management"
    echo -e "3) Security"
    echo -e "4) System Maintenance"
    echo -e "5) Exit"
    read -p "Enter your choice: " main_choice
    case $main_choice in
        1) network_optimization_menu ;;
        2) server_management_menu ;;
        3) security_menu ;;
        4) system_maintenance_menu ;;
        5) echo "Exiting..." ; exit 0 ;;
        *) echo "Invalid choice." ; sleep 2 ;;
    esac
done
