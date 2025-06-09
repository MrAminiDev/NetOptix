#!/bin/bash
#
# Auto change DNS server
#
# System Required: Debian8+, Ubuntu16+
#
# Copyright (C) 2024 Mr.Amini Nezhad
#
# my Github: https://github.com/MrAminiDev/

#!/bin/bash

# Display the options
echo "Select DNS provider:"
echo "1) Google DNS (8.8.8.8)"
echo "2) CloudFlare (1.1.1.1)"
echo "3) Shecan (Anti Tahrim)"
echo "4) begzar (Anti Tahrim)"

# Read user input
read -p "Enter your choice [1-3]: " choice

# Remove current DNS settings and set new DNS
case $choice in
    1)
        echo "Setting Google DNS..."
        sleep 5
        sed -i '/^nameserver /d' /etc/resolv.conf
        echo "nameserver 8.8.8.8" >> /etc/resolv.conf
        echo "nameserver 8.4.4.8" >> /etc/resolv.conf
        ;;
    2)
        echo "Setting CloudFlare DNS..."
        sleep 5
        sed -i '/^nameserver /d' /etc/resolv.conf
        echo "nameserver 1.1.1.1" >> /etc/resolv.conf
        echo "nameserver 1.0.0.1" >> /etc/resolv.conf
        ;;
    3)
        echo "Setting Shecan DNS..."
        sleep 5
        sed -i '/^nameserver /d' /etc/resolv.conf
        echo "nameserver 178.22.122.100" >> /etc/resolv.conf
        echo "nameserver 185.51.200.2" >> /etc/resolv.conf
        ;;
    4)
        echo "Setting begzar DNS..."
        sleep 5
        sed -i '/^nameserver /d' /etc/resolv.conf
        echo "nameserver 185.55.226.26" >> /etc/resolv.conf
        echo "nameserver 185.55.225.25  " >> /etc/resolv.conf
        ;;
    *)
        echo "Invalid choice. Exiting."
        exit 1
        ;;
esac

echo "DNS settings updated successfully."

sleep 5
