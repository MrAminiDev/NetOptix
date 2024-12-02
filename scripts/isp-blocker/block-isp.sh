#!/bin/bash
#
# Auto Block and unBlock Iran ISP list
#
# System Required: Debian8+, Ubuntu16+, Ubuntu24+
#
# Copyright (C) 2024 Mr.Amini Nezhad
#
# my Github: https://github.com/MrAminiDev/

install_prerequisites() {
    # Install iptables if not installed
    if ! command -v iptables &> /dev/null; then
        echo "iptables not found. Installing..."
        apt-get update
        apt-get install -y iptables
    fi

    # Install curl if not installed
    if ! command -v curl &> /dev/null; then
        echo "curl not found. Installing..."
        apt-get install -y curl
    fi

    # Install iptables-persistent for saving iptables rules
    if ! dpkg -l | grep -q iptables-persistent; then
        echo "iptables-persistent not found. Installing..."
        DEBIAN_FRONTEND=noninteractive apt-get install -y iptables-persistent
    fi

    # Install netfilter-persistent if not installed (required for iptables-persistent)
    if ! dpkg -l | grep -q netfilter-persistent; then
        echo "netfilter-persistent not found. Installing..."
        DEBIAN_FRONTEND=noninteractive apt-get install -y netfilter-persistent
    fi

    # Install essential packages for Ubuntu 24
    if ! dpkg -l | grep -q wget; then
        echo "wget not found. Installing..."
        apt-get install -y wget
    fi
}

save_iptables() {
    iptables-save > /etc/iptables/rules.v4
    echo "iptables rules saved."
}

block_ips() {
    url=$1
    isp_name=$2
    ips=$(curl -s $url)
    for ip in $ips; do
        iptables -A INPUT -s $ip -j DROP
    done
    save_iptables
    echo "All $isp_name IPs blocked."
    sleep 5
    clear
}

unblock_ips() {
    url=$1
    isp_name=$2
    ips=$(curl -s $url)
    for ip in $ips; do
        iptables -D INPUT -s $ip -j DROP
    done
    save_iptables
    echo "All $isp_name IPs unblocked."
    sleep 5
    clear
}

unblock_all() {
    iptables -F
    save_iptables
    echo "All ISP IPs unblocked."
    sleep 5
    clear
}

show_isp_menu() {
    clear
    while true; do
        echo "Choose an ISP:"
        echo "1) Irancell"
        echo "2) Hamrah-Aval (MCI)"
        echo "3) Rightel"
        echo "4) Shatel"
        echo "5) ICT (Mokhaberat)"
        echo "6) AfraNet"
        echo "7) ParsOnline"
        echo "8) AsiaTech"
        echo "9) Back to main menu"
        read -p "Enter your choice: " isp_choice

        case $isp_choice in
            1)
                isp_url="https://raw.githubusercontent.com/MrAminiDev/NetOptix/main/scripts/isp-blocker/isp/irancell.ipv4"
                isp_name="Irancell"
                break
                ;;
            2)
                isp_url="https://raw.githubusercontent.com/MrAminiDev/NetOptix/main/scripts/isp-blocker/isp/mci.ipv4"
                isp_name="MCI"
                break
                ;;
            3)
                isp_url="https://raw.githubusercontent.com/MrAminiDev/NetOptix/main/scripts/isp-blocker/isp/rightel.ipv4"
                isp_name="Rightel"
                break
                ;;
            4)
                isp_url="https://raw.githubusercontent.com/MrAminiDev/NetOptix/main/scripts/isp-blocker/isp/shatel.ipv4"
                isp_name="Shatel"
                break
                ;;
            5)
                isp_url="https://raw.githubusercontent.com/MrAminiDev/NetOptix/main/scripts/isp-blocker/isp/ict.ipv4"
                isp_name="ICT (Mokhaberat)"
                break
                ;;
            6)
                isp_url="https://raw.githubusercontent.com/MrAminiDev/NetOptix/main/scripts/isp-blocker/isp/afranet.ipv4"
                isp_name="AfraNet"
                break
                ;;
            7)
                isp_url="https://raw.githubusercontent.com/MrAminiDev/NetOptix/main/scripts/isp-blocker/isp/parsonline.ipv4"
                isp_name="ParsOnline"
                break
                ;;
            8)
                isp_url="https://raw.githubusercontent.com/MrAminiDev/NetOptix/main/scripts/isp-blocker/isp/asiatech.ipv4"
                isp_name="AsiaTech"
                break
                ;;
            9)
                return 1
                ;;
            *)
                echo "Invalid choice. Please try again."
                ;;
        esac
    done
}

main_menu() {
    clear
    while true; do
        echo "Please choose one of the options below"
        echo "1) Block ISP"
        echo "2) Unblock ISP"
        echo "3) Unblock all ISP"
        echo "4) Exit"
        read -p "Enter your choice: " main_choice

        case $main_choice in
            1)
                show_isp_menu
                if [ $? -eq 0 ]; then
                    block_ips $isp_url $isp_name
                fi
                ;;
            2)
                show_isp_menu
                if [ $? -eq 0 ]; then
                    unblock_ips $isp_url $isp_name
                fi
                ;;
            3)
                unblock_all
                ;;
            4)
                clear
                exit 0
                ;;
            *)
                echo "Invalid choice. Please try again."
                ;;
        esac
        clear
    done
}

# Install all necessary prerequisites
install_prerequisites

# Run the main menu
main_menu
