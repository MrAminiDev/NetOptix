#!/bin/bash

RED='\033[38;2;231;76;60m'
BLUE='\033[38;5;33m'
NC='\033[0m'

while true; do
    clear
    echo -e "${BLUE}+======================================================================+${NC}"
    echo -e "${BLUE}║       ${RED}▌║█║▌║▌│║▌║▌█║ NetOptix Coded By MrAmini ▌│║▌║▌║║▌█║${NC}   ${BLUE}        ║${NC}"
    echo -e "${BLUE}+======================================================================+${NC}"
    echo -e "${BLUE}+======================================================================+${NC}"
    echo -e "${BLUE}║    ${RED}        ▌║█║▌│║│║▌║▌█║ Main Menu  ▌│║▌║│║║▌█║▌       ${NC}   ${BLUE}          ║${NC}"
    echo -e "${BLUE}+======================================================================+${NC}"
    echo -e "${BLUE}+======================================================================+${NC}"
    echo -e "     ${RED}Open issues at https://github.com/MrAminiDev/NetOptix ${NC}"
    echo -e "${BLUE}+======================================================================+${NC}"
    echo -e "${BLUE}+======================================================================+${NC}"
    echo -e "                         ${RED}NetOptix V1.2.3 Beta  ${NC}"
    echo -e "${BLUE}+======================================================================+${NC}"
    echo "1- install Hybla"
    echo "2- install BBR"
    echo "3- Delete Optimize ( BBR and Hybla )"
    echo "4- Create Swap"
    echo "5- MTU Finder"
    echo "6- Exit menu"
    read -p "Enter your choice: " choice

    case $choice in
        1)
            echo "Running Hybla script..."
            sleep 2
            curl -fsSL https://raw.githubusercontent.com/MrAminiDev/NetOptix/main/scripts/hybla.sh -o /tmp/hybla.sh
            bash /tmp/hybla.sh
            rm /tmp/hybla.sh
            ;;
        2)
            echo "Running BBR script..."
            sleep 2
            curl -fsSL https://raw.githubusercontent.com/MrAminiDev/NetOptix/main/scripts/bbr.sh -o /tmp/bbr.sh
            bash /tmp/bbr.sh
            rm /tmp/bbr.sh
            ;;
        3)
            echo "Running Uninstall script..."
            sleep 2
            curl -fsSL https://raw.githubusercontent.com/MrAminiDev/NetOptix/main/scripts/uninstall.sh -o /tmp/uninstall.sh
            bash /tmp/uninstall.sh
            rm /tmp/uninstall.sh
            ;;
        4)
            echo "Running Swap script..."
            sleep 2
            curl -fsSL https://raw.githubusercontent.com/MrAminiDev/NetOptix/main/scripts/swap.sh -o /tmp/swap.sh
            bash /tmp/swap.sh
            rm /tmp/swap.sh
            ;;
        5)
            echo "Running MTU finder script..."
            sleep 2
            curl -fsSL https://raw.githubusercontent.com/MrAminiDev/NetOptix/main/scripts/mtu.sh -o /tmp/mtu.sh
            bash /tmp/mtu.sh
            rm /tmp/mtu.sh
            ;;
        6)
            echo "Exiting..."
            sleep 3
            exit 0
            ;;
        *)
            echo "Invalid choice. Please enter a valid option."
            read -p "Press Enter to continue..."
            ;;
    esac
done
