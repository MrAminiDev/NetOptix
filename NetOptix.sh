#!/bin/bash

# Color Definitions
RED='\033[38;2;231;76;60m'      # Red
BLUE='\033[38;5;32m'            # Blue
GREEN='\033[38;5;82m'           # Green
YELLOW='\033[38;5;226m'         # Yellow
CYAN='\033[38;5;51m'            # Cyan
MAGENTA='\033[38;5;171m'        # Magenta
NC='\033[0m'                    # No Color

while true; do
    clear
    echo -e "${CYAN}+======================================================================+${NC}"
    echo -e "${CYAN}║       ${RED}▌║█║▌║▌│║▌║▌█║ NetOptix Coded By MrAmini ▌│║▌║▌║║▌█║${NC}   ${CYAN}        ║${NC}"
    echo -e "${CYAN}+======================================================================+${NC}"
    echo -e "${CYAN}+======================================================================+${NC}"
    echo -e "${CYAN}║    ${RED}▌║█║▌│║│║▌║▌█║        Main Menu        ▌│║▌║│║║▌█║▌${NC}   ${CYAN}       ║${NC}"
    echo -e "${CYAN}+======================================================================+${NC}"
    echo -e "${CYAN}+======================================================================+${NC}"
    echo -e "     ${RED}Open issues at https://github.com/MrAminiDev/NetOptix ${NC}"
    echo -e "${CYAN}+======================================================================+${NC}"
    echo -e "${CYAN}+======================================================================+${NC}"
    echo -e "                         ${RED}NetOptix V3.2.0  ${NC}"
    echo -e "${CYAN}+======================================================================+${NC}"

    # Network Optimization (Green)
    echo -e "\n${GREEN}== Network Optimization ==${NC}"
    echo -e "${GREEN}1${NC}) ${YELLOW}Install Hybla${NC}"
    echo -e "${GREEN}2${NC}) ${YELLOW}Install BBR${NC}"
    echo -e "${GREEN}3${NC}) ${YELLOW}Delete Optimize (BBR and Hybla)${NC}"
    echo -e "${GREEN}4${NC}) ${YELLOW}Create Swap${NC}"
    echo -e "${GREEN}5${NC}) ${YELLOW}MTU Finder + Auto Set${NC}"
    echo -e "${GREEN}6${NC}) ${YELLOW}MTU Finder${NC}"

    # Server & Network Management (Blue)
    echo -e "\n${BLUE}== Server & Network Management ==${NC}"
    echo -e "${BLUE}7${NC}) ${CYAN}Block and Unblock Server Ping${NC}"
    echo -e "${BLUE}8${NC}) ${CYAN}Block Torrent List${NC}"
    echo -e "${BLUE}9${NC}) ${CYAN}Change Server DNS${NC}"
    echo -e "${BLUE}10${NC}) ${CYAN}Change SSH Port${NC}"
    echo -e "${BLUE}11${NC}) ${CYAN}Block and Unblock Private Network${NC}"
    echo -e "${BLUE}12${NC}) ${CYAN}Block and Unblock Iranian ISP${NC}"
    echo -e "${BLUE}13${NC}) ${CYAN}Install mikrotik on ubuntu${NC}"

    # Security (Red)
    echo -e "\n${RED}== Security ==${NC}"
    echo -e "${RED}14${NC}) ${CYAN}Install Fail2ban for SSH Security${NC}"
    echo -e "${RED}15${NC}) ${CYAN}Block and Unblock All SpeedTest Websites${NC}"

    # System Maintenance (Magenta)
    echo -e "\n${MAGENTA}== System Maintenance ==${NC}"
    echo -e "${MAGENTA}16${NC}) ${CYAN}Fix WhatsApp Data and Time${NC}"
    echo -e "${MAGENTA}17${NC}) ${CYAN}Disable IPv6${NC}"

    # Exit Option (Yellow)
    echo -e "\n${YELLOW}== Exit ==${NC}"
    echo -e "${YELLOW}18${NC}) ${CYAN}Exit Menu${NC}"

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
            echo "Running Private network blocker and unblocker..."
            sleep 2
            curl -fsSL https://raw.githubusercontent.com/MrAminiDev/NetOptix/main/scripts/pib.sh -o /tmp/pib.sh
            bash /tmp/pib.sh
            rm /tmp/pib.sh
            ;;
        12)
            echo "Running Iran ISP blocker and unblocker..."
            sleep 2
            curl -fsSL https://raw.githubusercontent.com/MrAminiDev/NetOptix/main/scripts/isp-blocker/block-isp.sh -o /tmp/block-isp.sh
            bash /tmp/block-isp.sh
            rm /tmp/block-isp.sh
            ;;
        13)
            echo "Running mikrotik installer on ubuntu..."
            sleep 2
            curl -fsSL https://raw.githubusercontent.com/MrAminiDev/NetOptix/main/scripts/mikrotik.sh -o /tmp/mikrotik.sh
            bash /tmp/mikrotik.sh
            rm /tmp/mikrotik.sh
            ;;
        14)
            echo "Running installer fail2ban script for ssh security..."
            sleep 2
            curl -fsSL https://raw.githubusercontent.com/MrAminiDev/NetOptix/main/scripts/fail2ban.sh -o /tmp/fail2ban.sh
            bash /tmp/fail2ban.sh
            rm /tmp/fail2ban.sh
            ;;
        15)
            echo "Running Speedtest blocker and unblocker..."
            sleep 2
            curl -fsSL https://raw.githubusercontent.com/MrAminiDev/NetOptix/main/scripts/speedtest/speedtest.sh -o /tmp/speedtest.sh
            bash /tmp/speedtest.sh
            rm /tmp/speedtest.sh
            ;;
        16)
            echo "Running WhatsApp Data and Time fixer..."
            sleep 2
            sudo timedatectl set-timezone Asia/Tehran
            sleep 2
            echo "Done, WhatsApp Data and Time fixed..."
            sleep 3
            ;;
        17)
            echo "Running IPv6 Disabling command..."
            sleep 2
            sudo sysctl -w net.ipv6.conf.all.disable_ipv6=1
            sudo sysctl -w net.ipv6.conf.default.disable_ipv6=1
            sudo sysctl -w net.ipv6.conf.lo.disable_ipv6=1
            echo "Done, IPv6 Disabled..."
            sleep 3
            ;;
        18)
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
