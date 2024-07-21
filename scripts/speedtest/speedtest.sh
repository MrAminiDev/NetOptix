#!/bin/bash
#
# Auto block and unblock SpeedTest site
#
# System Required:  CentOS 6+, Debian8+, Ubuntu16+
#
# Copyright (C) 2024 Mr.Amini Nezhad
#
# my Github: https://github.com/MrAminiDev/

command -v iptables >/dev/null 2>&1 || { echo >&2 "iptables is required but it's not installed. Aborting."; exit 1; }

LIST_FILE="https://raw.githubusercontent.com/MrAminiDev/NetOptix/main/scripts/speedtest/speedtest.list"
IPTABLES_SAVE="/etc/iptables/rules.v4"

# Function to block sites and IPs
block_sites() {
    if [ ! -f "$LIST_FILE" ]; then
        echo "The list file $LIST_FILE does not exist."
        exit 1
    fi
    
    while IFS= read -r site; do
        # Blocking by domain name
        iptables -A OUTPUT -p tcp -m string --string "$site" --algo bm --to 65535 -j REJECT
        # Resolving domain to IP and blocking by IP address
        for ip in $(dig +short "$site"); do
            iptables -A OUTPUT -d "$ip" -j REJECT
        done
    done < "$LIST_FILE"

    iptables-save > "$IPTABLES_SAVE"
    clear
    echo "All speed test websites and related IPs are blocked successfully."
    sleep 5
}

unblock_sites() {
    if [ ! -f "$LIST_FILE" ]; then
        echo "The list file $LIST_FILE does not exist."
        exit 1
    fi

    while IFS= read -r site; do
        # Unblocking by domain name
        iptables -D OUTPUT -p tcp -m string --string "$site" --algo bm --to 65535 -j REJECT
        # Resolving domain to IP and unblocking by IP address
        for ip in $(dig +short "$site"); do
            iptables -D OUTPUT -d "$ip" -j REJECT
        done
    done < "$LIST_FILE"

    iptables-save > "$IPTABLES_SAVE"
    clear
    echo "All speed test websites and related IPs are unblocked successfully."
    sleep 5
}

while true; do
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
