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
    echo -e "                         ${RED}NetOptix V3.0.0  ${NC}"
    echo -e "${BLUE}+======================================================================+${NC}"
    echo "1- install Hybla"
    echo "2- install BBR"
    echo "3- Delete Optimize ( BBR and Hybla )"
    echo "4- Create Swap"
    echo "5- MTU Finder + auto set"
    echo "6- MTU Finder"
    echo "7- Block and unBlock Server Ping"
    echo "8- Block torrent list"
    echo "9- Change Server DNS"
    echo "10- change SSH port"
    echo "11- Block and unBlock Private network"
    echo "12- Block and unBlock Iranian ISP"
    echo "13- Install fail2ban for ssh security"
    echo "14- Block and unBlock All SpeedTest website"
    echo "15- Fix WhatsApp Data and Time"
    echo "16- Disable IPv6"
    echo "17- Exit menu"
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
            echo "Running MTU finder + auto set script..."
            sleep 2
            curl -fsSL https://raw.githubusercontent.com/MrAminiDev/NetOptix/main/scripts/mtu.sh -o /tmp/mtu.sh
            bash /tmp/mtu.sh
            rm /tmp/mtu.sh
            ;;
        6)
            echo "Running MTU finder script..."
            sleep 2
            curl -fsSL https://raw.githubusercontent.com/MrAminiDev/NetOptix/main/scripts/mtunoset.sh -o /tmp/mtunoset.sh
            bash /tmp/mtunoset.sh
            rm /tmp/mtunoset.sh
            ;;
        7)
            echo "Running Server Ping Blocker..."
            sleep 2
            curl -fsSL https://raw.githubusercontent.com/MrAminiDev/NetOptix/main/scripts/Ping.sh -o /tmp/Ping.sh
            bash /tmp/Ping.sh
            rm /tmp/Ping.sh
            ;;
        8)
            echo "Running Block torrent list..."
            sleep 2
            curl -fsSL https://raw.githubusercontent.com/MrAminiDev/NetOptix/main/scripts/blocktorrent/blocktorrent.sh -o /tmp/blocktorrent.sh
            bash /tmp/blocktorrent.sh
            rm /tmp/blocktorrent.sh
            ;;
        9)
            echo "Running Server DNS changer..."
            sleep 2
            curl -fsSL https://raw.githubusercontent.com/MrAminiDev/NetOptix/main/scripts/dns.sh -o /tmp/dns.sh
            bash /tmp/dns.sh
            rm /tmp/dns.sh
            ;;
        10)
            echo "Running SSH port changer..."
            sleep 2
            curl -fsSL https://raw.githubusercontent.com/MrAminiDev/NetOptix/main/scripts/cport.sh -o /tmp/cport.sh
            bash /tmp/cport.sh
            rm /tmp/cport.sh
            ;;
        11)
            echo "Running Private network blocker an unblocker..."
            sleep 2
            curl -fsSL https://raw.githubusercontent.com/MrAminiDev/NetOptix/main/scripts/pib.sh -o /tmp/pib.sh
            bash /tmp/pib.sh
            rm /tmp/pib.sh
            ;;
        12)
            echo "Running Iran ISP blocker an unblocker..."
            sleep 2
            curl -fsSL https://raw.githubusercontent.com/MrAminiDev/NetOptix/main/scripts/isp-blocker/block-isp.sh -o /tmp/block-isp.sh
            bash /tmp/block-isp.sh
            rm /tmp/block-isp.sh
            ;;
        13)
            echo "Running installer fail2ban script for ssh security..."
            sleep 2
            curl -fsSL https://raw.githubusercontent.com/MrAminiDev/NetOptix/main/scripts/fail2ban.sh -o /tmp/fail2ban.sh
            bash /tmp/fail2ban.sh
            rm /tmp/fail2ban.sh
            ;;
        14)
            echo "Running Speedtest blocker an unblocker..."
            sleep 2
            curl -fsSL https://raw.githubusercontent.com/MrAminiDev/NetOptix/main/scripts/speedtest/speedtest.sh -o /tmp/speedtest.sh
            bash /tmp/speedtest.sh
            rm /tmp/speedtest.sh
            ;;
        15)
            echo "Running WhatsApp Data and Time fixer..."
            sleep 2
            sudo timedatectl set-timezone Asia/Tehran
            sleep 2
            echo "Done, WhatsApp Data and Time fixed..."
            sleep 3
            ;;
        16)
            echo "Running IPv6 Disabling command..."
            sleep 2
            sudo sysctl -w net.ipv6.conf.all.disable_ipv6=1
            sudo sysctl -w net.ipv6.conf.default.disable_ipv6=1
            sudo sysctl -w net.ipv6.conf.lo.disable_ipv6=1
            echo "Done, IPv6 Disabled..."
            sleep 3
            ;;
        17)
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
