#!/bin/bash

# Color Definitions
RED='\033[38;2;231;76;60m'      # Red
BLUE='\033[38;5;32m'            # Blue
GREEN='\033[38;5;82m'           # Green
YELLOW='\033[38;5;226m'         # Yellow
CYAN='\033[38;5;51m'            # Cyan
MAGENTA='\033[38;5;171m'        # Magenta
NC='\033[0m'                    # No Color

create_quick_command() {
    local quick_command_path="/usr/local/bin/netoptix"
    echo "Creating quick command 'netoptix'..."
    sudo bash -c "cat > $quick_command_path" << 'EOF'
curl -fsSL https://raw.githubusercontent.com/MrAminiDev/NetOptix/refs/heads/main/NetOptix.sh -o /tmp/netoptix.sh
bash /tmp/netoptix.sh
rm /tmp/netoptix.sh
EOF
    sudo chmod +x $quick_command_path
    echo -e "${GREEN}Quick command 'netoptix' created successfully. You can now run 'netoptix' from anywhere.${NC}"
}

# Functions for Submenus
network_optimization_menu() {
    while true; do
        clear
        echo -e "${GREEN}== Network & Server Optimization ==${NC}"
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
            1)
                echo "Running Hybla script..."
                curl -fsSL https://raw.githubusercontent.com/MrAminiDev/NetOptix/main/scripts/hybla.sh -o /tmp/hybla.sh
                bash /tmp/hybla.sh
                rm /tmp/hybla.sh
                ;;
            2)
                echo "Running BBR script..."
                curl -fsSL https://raw.githubusercontent.com/MrAminiDev/NetOptix/main/scripts/bbr.sh -o /tmp/bbr.sh
                bash /tmp/bbr.sh
                rm /tmp/bbr.sh
                ;;
            3)
                echo "Running Uninstall script..."
                curl -fsSL https://raw.githubusercontent.com/MrAminiDev/NetOptix/main/scripts/uninstall.sh -o /tmp/uninstall.sh
                bash /tmp/uninstall.sh
                rm /tmp/uninstall.sh
                ;;
            4)
                echo "Running Swap script..."
                curl -fsSL https://raw.githubusercontent.com/MrAminiDev/NetOptix/main/scripts/swap.sh -o /tmp/swap.sh
                bash /tmp/swap.sh
                rm /tmp/swap.sh
                ;;
            5)
                echo "Running ZRAM script..."
                curl -fsSL https://raw.githubusercontent.com/MrAminiDev/NetOptix/main/scripts/zram.sh -o /tmp/zram.sh
                bash /tmp/zram.sh
                rm /tmp/zram.sh
                ;;
            6)
                echo "Running MTU Finder + Auto Set script..."
                curl -fsSL https://raw.githubusercontent.com/MrAminiDev/NetOptix/main/scripts/mtu.sh -o /tmp/mtu.sh
                bash /tmp/mtu.sh
                rm /tmp/mtu.sh
                ;;
            7)
                echo "Running MTU Finder script..."
                curl -fsSL https://raw.githubusercontent.com/MrAminiDev/NetOptix/main/scripts/mtunoset.sh -o /tmp/mtunoset.sh
                bash /tmp/mtunoset.sh
                rm /tmp/mtunoset.sh
                ;;
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
            1)
                echo "Running Server Ping Blocker..."
                curl -fsSL https://raw.githubusercontent.com/MrAminiDev/NetOptix/main/scripts/Ping.sh -o /tmp/Ping.sh
                bash /tmp/Ping.sh
                rm /tmp/Ping.sh
                ;;
            2)
                echo "Running Block Torrent List..."
                curl -fsSL https://raw.githubusercontent.com/MrAminiDev/NetOptix/main/scripts/blocktorrent/blocktorrent.sh -o /tmp/blocktorrent.sh
                bash /tmp/blocktorrent.sh
                rm /tmp/blocktorrent.sh
                ;;
            3)
                echo "Running Server DNS Changer..."
                curl -fsSL https://raw.githubusercontent.com/MrAminiDev/NetOptix/main/scripts/dns.sh -o /tmp/dns.sh
                bash /tmp/dns.sh
                rm /tmp/dns.sh
                ;;
            4)
                echo "Running SSH Port Changer..."
                curl -fsSL https://raw.githubusercontent.com/MrAminiDev/NetOptix/main/scripts/cport.sh -o /tmp/cport.sh
                bash /tmp/cport.sh
                rm /tmp/cport.sh
                ;;
            5)
                echo "Running Private Network Blocker..."
                curl -fsSL https://raw.githubusercontent.com/MrAminiDev/NetOptix/main/scripts/pib.sh -o /tmp/pib.sh
                bash /tmp/pib.sh
                rm /tmp/pib.sh
                ;;
            6)
                echo "Running Iranian ISP Blocker..."
                curl -fsSL https://raw.githubusercontent.com/MrAminiDev/NetOptix/main/scripts/isp-blocker/block-isp.sh -o /tmp/block-isp.sh
                bash /tmp/block-isp.sh
                rm /tmp/block-isp.sh
                ;;
            7)
                echo "Running Mikrotik Installer..."
                curl -fsSL https://raw.githubusercontent.com/MrAminiDev/NetOptix/main/scripts/mikrotik.sh -o /tmp/mikrotik.sh
                bash /tmp/mikrotik.sh
                rm /tmp/mikrotik.sh
                ;;
            8)
                echo "Installing Monitoring System..."
                sudo apt update
                sudo apt install cockpit
                sudo systemctl start cockpit
                echo "Done. Access the monitoring system via IP:9090. (User: root / Password: server password)"
                sleep 10
                ;;
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
	echo -e "3) Install ClamAV ( Server AntiVirus )"
        echo -e "0) Back to Main Menu"
        read -p "Enter your choice: " choice
        case $choice in
            1)
                echo "Installing Fail2ban..."
                curl -fsSL https://raw.githubusercontent.com/MrAminiDev/NetOptix/main/scripts/fail2ban.sh -o /tmp/fail2ban.sh
                bash /tmp/fail2ban.sh
                rm /tmp/fail2ban.sh
                ;;
            2)
                echo "Running SpeedTest Blocker..."
                curl -fsSL https://raw.githubusercontent.com/MrAminiDev/NetOptix/main/scripts/speedtest/speedtest.sh -o /tmp/speedtest.sh
                bash /tmp/speedtest.sh
                rm /tmp/speedtest.sh
                ;;
            3)
	    echo "Running ClamAV installer..."
                curl -fsSL https://raw.githubusercontent.com/MrAminiDev/NetOptix/main/scripts/ClamAV.sh -o /tmp/ClamAV.sh
                bash /tmp/ClamAV.sh
                rm /tmp/ClamAV.sh
                ;;
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
            1)
                echo "Fixing WhatsApp Data and Time..."
                sudo timedatectl set-timezone Asia/Tehran
                echo "Done. WhatsApp data and time fixed."
                sleep 3
                ;;
            2)
                echo "Disabling IPv6..."
                sudo sysctl -w net.ipv6.conf.all.disable_ipv6=1
                sudo sysctl -w net.ipv6.conf.default.disable_ipv6=1
                sudo sysctl -w net.ipv6.conf.lo.disable_ipv6=1
                echo "Done. IPv6 Disabled."
                sleep 3
                ;;
            0) return ;;
            *) echo "Invalid choice." ; sleep 2 ;;
        esac
    done
}

# Main Menu
while true; do
    clear
    echo -e "${CYAN}+======================================================================+${NC}"
    echo -e "${RED}##    ## ######## ########  #######  ########  ######## #### ##     ## ${NC}"
    echo -e "${RED}###   ## ##          ##    ##     ## ##     ##    ##     ##   ##   ##  ${NC}"
    echo -e "${RED}####  ## ##          ##    ##     ## ##     ##    ##     ##    ## ##   ${NC}"
    echo -e "${RED}## ## ## ######      ##    ##     ## ########     ##     ##     ###    ${NC}"
    echo -e "${RED}##  #### ##          ##    ##     ## ##           ##     ##    ## ##   ${NC}"
    echo -e "${RED}##   ### ##          ##    ##     ## ##           ##     ##   ##   ##  ${NC}"
    echo -e "${RED}##    ## ########    ##     #######  ##           ##    #### ##     ## ${NC}"
    echo -e "${CYAN}+======================================================================+${NC}"
    echo -e "|  Telegram Channel : ${MAGENTA}@AminiDev ${NC}|  Version : ${GREEN} 4.2.2${NC} "
    echo -e "${CYAN}+======================================================================+${NC}"
    echo -e "${CYAN}== Main Menu ==${NC}"
    echo -e "1) Network & Server Optimization"
    echo -e "2) Server & Network Management"
    echo -e "3) Security"
    echo -e "4) System Maintenance"
    echo -e "0) Exit"
    read -p "Enter your choice: " main_choice
    case $main_choice in
        1) network_optimization_menu ;;
        2) server_management_menu ;;
        3) security_menu ;;
        4) system_maintenance_menu ;;
        0)
            create_quick_command
            echo "Exiting..."
            exit 0 ;;
        *) echo "Invalid choice." ; sleep 2 ;;
    esac
done
