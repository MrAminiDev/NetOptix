#!/bin/bash
#
# Auto Block and unBlock Iran ISP list
#
# System Required: Debian8+, Ubuntu16+
#
# Copyright (C) 2024 Mr.Amini Nezhad
#
# my Github: https://github.com/MrAminiDev/

install_prerequisites() {
    if ! command -v iptables &> /dev/null; then
        echo "iptables not found. Installing..."
        apt-get update
        apt-get install -y iptables
    fi
    if ! command -v curl &> /dev/null; then
        echo "curl not found. Installing..."
        apt-get update
        apt-get install -y curl
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
    echo "Choose an ISP:"
    echo "1) Irancell"
    echo "2) Hamrah-Aval (MCI)"
    echo "3) Rightel"
    read -p "Enter your choice: " isp_choice

    case $isp_choice in
        1)
            isp_url="https://raw.githubusercontent.com/MrAminiDev/NetOptix/main/scripts/isp-blocker/isp/irancell.ipv4"
            isp_name="Irancell"
            ;;
        2)
            isp_url="https://raw.githubusercontent.com/MrAminiDev/NetOptix/main/scripts/isp-blocker/isp/mci.ipv4"
            isp_name="MCI"
            ;;
        3)
            isp_url="https://raw.githubusercontent.com/MrAminiDev/NetOptix/main/scripts/isp-blocker/isp/rightel.ipv4"
            isp_name="Rightel"
            ;;
        *)
            echo "Invalid choice."
            exit 1
            ;;
    esac
}

main_menu() {
    clear
    echo "Please choose one of the options below"
    echo "1) Block ISP"
    echo "2) Unblock ISP"
    echo "3) Unblock all ISP"
    read -p "Enter your choice: " main_choice

    case $main_choice in
        1)
            show_isp_menu
            block_ips $isp_url $isp_name
            ;;
        2)
            show_isp_menu
            unblock_ips $isp_url $isp_name
            ;;
        3)
            unblock_all
            ;;
        *)
            echo "Invalid choice."
            exit 1
            ;;
    esac
    clear
}

install_prerequisites

if ! dpkg -l | grep -q iptables-persistent; then
    echo "iptables-persistent not found. Installing..."
    apt-get update
    DEBIAN_FRONTEND=noninteractive apt-get install -y iptables-persistent
fi

main_menu
