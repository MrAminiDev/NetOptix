#!/bin/bash
#
# Auto install Swap
#
# System Required:  CentOS 6+, Debian8+, Ubuntu16+
#
# Copyright (C) 2024 Mr.Amini Nezhad
#
# my Github: https://github.com/MrAminiDev/

install_prerequisites() {
    echo "Checking for prerequisites..."
    if ! command -v modprobe &> /dev/null; then
        echo "Installing kmod package for modprobe..."
        sudo apt update && sudo apt install -y kmod
    fi
    if ! ls /sys/block/ | grep -q zram0; then
        echo "Installing zram-tools package..."
        sudo apt update && sudo apt install -y zram-tools
    fi
    echo "Prerequisites installed."
}

define_zram() {
    read -p "Enter the size of ZRAM in MB: " zram_size
    if [[ $zram_size =~ ^[0-9]+$ ]]; then
        echo "Creating ZRAM of size ${zram_size}MB..."
        sudo modprobe zram
        echo "zram" > /sys/block/zram0/disksize
        sudo bash -c "echo $(($zram_size * 1024 * 1024)) > /sys/block/zram0/disksize"
        sudo mkswap /dev/zram0
        sudo swapon /dev/zram0
        echo "ZRAM created and activated."
    else
        echo "Invalid size entered. Please enter a numeric value in MB."
    fi
}

delete_zram() {
    echo "Removing ZRAM..."
    sudo swapoff /dev/zram0
    sudo modprobe -r zram
    echo "ZRAM removed."
}

install_prerequisites

while true; do
    echo "Choose an option:"
    echo "1 - Create ZRAM"
    echo "2 - Delete ZRAM"
    echo "q - Quit"
    read -p "Enter your choice: " choice

    case $choice in
        1)
            define_zram
            ;;
        2)
            delete_zram
            ;;
        q)
            echo "Exiting..."
            exit 0
            ;;
        *)
            echo "Invalid option. Please choose 1, 2, or q."
            ;;
    esac

done
