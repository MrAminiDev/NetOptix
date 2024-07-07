#!/bin/bash
#
# Auto change SSH port
#
# System Required:  CentOS 6+, Debian8+, Ubuntu16+
#
# Copyright (C) 2024 Mr.Amini Nezhad
#
# my Github: https://github.com/MrAminiDev/

read -p "Please enter the new SSH port: " new_port

if [[ $new_port -lt 1 || $new_port -gt 65535 ]]; then
    echo "Invalid port number. Please enter a number between 1 and 65535."
    exit 1
fi

cp /etc/ssh/sshd_config /etc/ssh/sshd_config.bak

sed -i "s/^#Port 22/Port $new_port/" /etc/ssh/sshd_config
sed -i "s/^Port [0-9]*/Port $new_port/" /etc/ssh/sshd_config

systemctl restart ssh

echo "SSH port successfully changed to $new_port."
sleep 5
if command -v ufw > /dev/null 2>&1; then
    ufw allow $new_port/tcp
    ufw reload
    echo "New port added to the firewall."
elif command -v firewall-cmd > /dev/null 2>&1; then
    firewall-cmd --permanent --add-port=$new_port/tcp
    firewall-cmd --reload
    echo "New port added to the firewall."
else
    echo "Firewall is not supported or not installed. Please add the new port manually."
fi
