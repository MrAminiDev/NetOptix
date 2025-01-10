#!/bin/bash
#
# Auto install Swap
#
# System Required:  CentOS 6+, Debian8+, Ubuntu16+
#
# Copyright (C) 2025 Mr.Amini Nezhad
#
# my Github: https://github.com/MrAminiDev/

install_clamav() {
    echo "Updating package list..."
    sudo apt update
    echo "Installing ClamAV..."
    sudo apt install -y clamav clamav-daemon
    echo "ClamAV has been installed successfully."
}

uninstall_clamav() {
    echo "Removing ClamAV..."
    sudo apt remove -y clamav clamav-daemon
    sudo apt autoremove -y
    echo "ClamAV has been uninstalled successfully."
}

echo "Choose an option:"
echo "1 - Install ClamAV"
echo "2 - Uninstall ClamAV"
read -p "Enter your choice (1 or 2): " choice

case $choice in
    1)
        install_clamav
        ;;
    2)
        uninstall_clamav
        ;;
    *)
        echo "Invalid choice. Please run the script again and choose 1 or 2."
        ;;
esac
