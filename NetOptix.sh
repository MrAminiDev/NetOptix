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
    echo -e "                         ${RED}NetOptix V1.0  ${NC}"
    echo -e "${BLUE}+======================================================================+${NC}"
    echo "1- install Hybla"
    echo "2- install BBR"
    echo "3- Delete Optimize"
    echo "4- Create Swap"
    echo "5- Exit menu"
    read -p "Enter your choice: " choice

    case $choice in
        1)
            echo "Running Hybla script..."
            sleep 2
            bash <(curl -fsSL https://raw.githubusercontent.com/MrAminiDev/NetOptix/main/scripts/hybla.sh)
            ;;
        2)
            echo "Running BBR script..."
            sleep 2
            bash <(curl -fsSL https://raw.githubusercontent.com/MrAminiDev/NetOptix/main/scripts/bbr.sh)
            ;;
        3)
            echo "Running Uninstall script..."
            sleep 2
            bash <(curl -fsSL https://raw.githubusercontent.com/MrAminiDev/NetOptix/main/scripts/uninstall.sh)
            ;;
        4)
            echo "Running Swap script..."
            sleep 2
            bash <(curl -fsSL https://raw.githubusercontent.com/MrAminiDev/NetOptix/main/scripts/uninstall.sh)
            ;;
        5)
            echo "Exiting..."
            sleep 2
            exit 0
            ;;
        *)
            echo "Invalid choice. Please enter a valid option."
            ;;
    esac

    read -p "Press Enter to continue..."
done

