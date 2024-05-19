#!/bin/bash
#
# Auto install Swap
#
# System Required:  CentOS 6+, Debian8+, Ubuntu16+
#
# Copyright (C) 2024 Mr.Amini Nezhad
#
# my Github: https://github.com/MrAminiDev/

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root. Please use sudo." 
   exit 1
fi

read -p "Please enter the amount of swap space in MB: " swap_size

if ! [[ "$swap_size" =~ ^[0-9]+$ ]]; then
    echo "Please enter a valid number."
    exit 1
fi

block_size=$((swap_size * 1024))

swap_file="/swapfile"

fallocate -l ${swap_size}M $swap_file

chmod 600 $swap_file

mkswap $swap_file

swapon $swap_file

echo "$swap_file none swap sw 0 0" | tee -a /etc/fstab

echo "Swap space of ${swap_size}MB successfully created and enabled."

read -p "Press Enter to continue..."

xdg-open https://raw.githubusercontent.com/MrAminiDev/NetOptix/main/NetOptix.sh

swapon --show