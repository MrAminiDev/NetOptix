#!/bin/bash
#
# Auto block and unblock SpeedTest site
#
# System Required:  CentOS 6+, Debian8+, Ubuntu16+
#
# Copyright (C) 2024 Mr.Amini Nezhad
#
# my Github: https://github.com/MrAminiDev/

echo "Checking required packages..."

if ! command -v iptables >/dev/null 2>&1; then
    echo "iptables is not installed. Installing..."
    sudo apt update && sudo apt install -y iptables
else
    echo "iptables is already installed."
fi

if ! command -v curl >/dev/null 2>&1; then
    echo "curl is not installed. Installing..."
    sudo apt update && sudo apt install -y curl
else
    echo "curl is already installed."
fi

if ! command -v dig >/dev/null 2>&1; then
    echo "dig is not installed. Installing..."
    sudo apt update && sudo apt install -y dnsutils
else
    echo "dig is already installed."
fi

LIST_URL="https://raw.githubusercontent.com/MrAminiDev/NetOptix/main/scripts/speedtest/speedtest.list"
IPTABLES_SAVE="/etc/iptables/rules.v4"

block_sites() {
    curl -s "$LIST_URL" | while IFS= read -r site; do
        iptables -A OUTPUT -p tcp -m string --string "$site" --algo bm --to 65535 -j REJECT
        for ip in $(dig +short "$site"); do
            iptables -A OUTPUT -d "$ip" -j REJECT
        done
    done

    iptables-save > "$IPTABLES_SAVE"
    clear
    echo "All speed test websites and related IPs are blocked successfully."
    sleep 5
}

unblock_sites() {
    curl -s "$LIST_URL" | while IFS= read -r site; do
        iptables -D OUTPUT -p tcp -m string --string "$site" --algo bm --to 65535 -j REJECT
        for ip in $(dig +short "$site"); do
            iptables -D OUTPUT -d "$ip" -j REJECT
        done
    done

    iptables-save > "$IPTABLES_SAVE"
    clear
    echo "All speed test websites and related IPs are unblocked successfully."
    sleep 5
}

while true; do
    clear
    echo "Select an option:"
    echo "1. Block SpeedTest Site"
    echo "2. Unblock SpeedTest Site"
    echo "3. Exit"
    read -rp "Enter your choice: " choice

    case $choice in
        1) block_sites ;;
        2) unblock_sites ;;
        3) exit 0 ;;
        *) echo "Invalid option. Please try again." ;;
    esac
done
