#!/bin/bash
#
# Install and configure fail2ban automatically to increase ssh security
#
# System Required: Debian8+, Ubuntu16+
#
# Copyright (C) 2024 Mr.Amini Nezhad
#
# my Github: https://github.com/MrAminiDev/

install_and_configure_fail2ban() {
    if ! command -v fail2ban-server &> /dev/null; then
        echo "fail2ban not found, installing..."
        sudo apt update && sudo apt install -y fail2ban
    else
        echo "fail2ban is already installed."
    fi

    sudo bash -c 'cat > /etc/fail2ban/jail.local' <<EOL
[sshd]
enabled = true
port = ssh
filter = sshd
logpath = /var/log/auth.log
maxretry = 5
bantime = 86400
EOL

    sudo systemctl restart fail2ban
    sudo systemctl enable fail2ban
    clear
    echo "fail2ban has been successfully activated"
    sleep 5
}

disable_fail2ban() {
    sudo systemctl stop fail2ban
    sudo systemctl disable fail2ban
    clear
    echo "fail2ban has been successfully Disabled"
    sleep 5
}

clear_ban_list() {
    sudo fail2ban-client unban --all
    clear
    echo "The blocked list has been successfully emptied"
    sleep 5
}

while true; do
    clear
    echo "Please select an option:"
    echo "1 - Enable fail2ban"
    echo "2 - Disable fail2ban"
    echo "3 - Clean ban list"
    echo "4 - Exit"
    read -rp "Enter your choice: " choice

    case $choice in
        1)
            install_and_configure_fail2ban
            break
            ;;
        2)
            disable_fail2ban
            break
            ;;
        3)
            clear_ban_list
            break
            ;;
        4)
            exit 0
            ;;
        *)
            echo "Invalid option, please try again."
            sleep 1
            ;;
    esac
done
