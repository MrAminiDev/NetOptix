#!/bin/bash
#
# Auto install ClamAV
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

list_clamav_commands() {
    echo "ClamAV Common Commands:"
    echo "1. freshclam - Update the ClamAV virus database."
    echo "   Usage: freshclam"
    echo "2. clamscan - Scan files or directories for viruses."
    echo "   Options:"
    echo "     -r : Scan directories recursively"
    echo "     --remove : Remove infected files"
    echo "     --log=FILE : Log scan results to a file"
    echo "   Example: clamscan -r --remove --log=scan.log /path/to/scan"
    echo "3. clamdscan - Scan using the ClamAV daemon for better performance."
    echo "   Options:"
    echo "     --multiscan : Enable multi-threaded scanning"
    echo "     --fdpass : Pass file descriptors to clamd"
    echo "   Example: clamdscan --multiscan /path/to/scan"
    echo "4. clamdtop - Monitor ClamAV daemon status in real-time."
    echo "   Usage: clamdtop"
    echo "5. sigtool - Manage ClamAV signature files."
    echo "   Options:"
    echo "     --md5 : Generate MD5 checksum of a file"
    echo "     --unpack : Unpack a ClamAV signature file"
    echo "   Example: sigtool --md5 /path/to/file"
    echo "6. clamsubmit - Submit files to ClamAV team for analysis."
    echo "   Usage: clamsubmit /path/to/suspicious_file"
}
clear
echo "Choose an option:"
echo "1 - Install ClamAV"
echo "2 - Uninstall ClamAV"
echo "3 - List ClamAV Commands"
echo "0 - Quit"
read -p "Enter your choice: " choice

case $choice in
    1)
        install_clamav
        ;;
    2)
        uninstall_clamav
        ;;
    3)
        list_clamav_commands
        ;;
        0)
        echo "Exiting..."
        exit 0
        ;;
    *)
        echo "Invalid choice. Please run the script again and choose 1, 2, or 3."
        ;;
esac

