#!/bin/bash
#
# Auto Disable ping server
#
# System Required: Debian8+, Ubuntu16+
#
# Copyright (C) 2024 Mr.Amini Nezhad
#
# my Github: https://github.com/MrAminiDev/


disable_ping() {
    sudo iptables -A INPUT -p icmp --icmp-type echo-request -j DROP
    sudo netfilter-persistent save
    echo "Ping requests have been blocked and settings saved."
}

enable_ping() {
    sudo iptables -D INPUT -p icmp --icmp-type echo-request -j DROP
    sudo netfilter-persistent save
    echo "Ping requests have been unblocked and settings saved."
}

while true; do
    clear
    echo "Please select an option:"
    echo "1) Disable Server Ping"
    echo "2) Enable Server Ping"
    echo "3) Exit"
    echo
    read -p "Enter your choice [1-3]: " choice

    case $choice in
        1)
            disable_ping
            ;;
        2)
            enable_ping
            ;;
        3)
            echo "Exiting script."
            exit 0
            ;;
        *)
            echo "Invalid option! Please enter a number between 1 and 3."
            ;;
    esac

    read -p "Press any key to continue..." -n1 -s
done
