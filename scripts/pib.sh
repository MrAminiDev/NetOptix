#!/bin/bash
#
# Auto block and unblock private ip
#
# more info https://en.wikipedia.org/wiki/Reserved_IP_addresses
#
# System Required:  CentOS 6+, Debian8+, Ubuntu16+
#
# Copyright (C) 2024 Mr.Amini Nezhad
#
# my Github: https://github.com/MrAminiDev/

block_ips() {
    iptables -A INPUT -s 0.0.0.0/8 -j DROP
    iptables -A OUTPUT -d 0.0.0.0/8 -j DROP
    iptables -A INPUT -s 10.0.0.0/8 -j DROP
    iptables -A OUTPUT -d 10.0.0.0/8 -j DROP
    iptables -A INPUT -s 100.64.0.0/10 -j DROP
    iptables -A OUTPUT -d 100.64.0.0/10 -j DROP
    iptables -A INPUT -s 127.0.0.0/8 -j DROP
    iptables -A OUTPUT -d 127.0.0.0/8 -j DROP
    iptables -A INPUT -s 169.254.0.0/16 -j DROP
    iptables -A OUTPUT -d 169.254.0.0/16 -j DROP
    iptables -A INPUT -s 172.16.0.0/12 -j DROP
    iptables -A OUTPUT -d 172.16.0.0/12 -j DROP
    iptables -A INPUT -s 192.0.0.0/24 -j DROP
    iptables -A OUTPUT -d 192.0.0.0/24 -j DROP
    iptables -A INPUT -s 192.0.2.0/24 -j DROP
    iptables -A OUTPUT -d 192.0.2.0/24 -j DROP
    iptables -A INPUT -s 192.88.99.0/24 -j DROP
    iptables -A OUTPUT -d 192.88.99.0/24 -j DROP
    iptables -A INPUT -s 192.168.0.0/16 -j DROP
    iptables -A OUTPUT -d 192.168.0.0/16 -j DROP
    iptables -A INPUT -s 198.18.0.0/15 -j DROP
    iptables -A OUTPUT -d 198.18.0.0/15 -j DROP
    iptables -A INPUT -s 198.51.100.0/24 -j DROP
    iptables -A OUTPUT -d 198.51.100.0/24 -j DROP
    iptables -A INPUT -s 203.0.113.0/24 -j DROP
    iptables -A OUTPUT -d 203.0.113.0/24 -j DROP
    iptables -A INPUT -s 224.0.0.0/4 -j DROP
    iptables -A OUTPUT -d 224.0.0.0/4 -j DROP
    iptables -A INPUT -s 233.252.0.0/24 -j DROP
    iptables -A OUTPUT -d 233.252.0.0/24 -j DROP
    iptables -A INPUT -s 240.0.0.0/4 -j DROP
    iptables -A OUTPUT -d 240.0.0.0/4 -j DROP
    iptables -A INPUT -s 255.255.255.255/32 -j DROP
    iptables -A OUTPUT -d 255.255.255.255/32 -j DROP

    iptables-save > /etc/iptables/rules.v4

    apt-get install -y iptables-persistent

    cat <<EOF > /etc/systemd/system/iptables-restore.service
[Unit]
Description=Restore iptables rules

[Service]
Type=oneshot
ExecStart=/sbin/iptables-restore < /etc/iptables/rules.v4
ExecReload=/sbin/iptables-restore < /etc/iptables/rules.v4
RemainAfterExit=yes

[Install]
WantedBy=multi-user.target
EOF

    systemctl enable iptables-restore.service
    systemctl start iptables-restore.service

    clear
    echo "All Private IP ranges have been blocked."
    sleep 5
}

unblock_ips() {
    iptables -D INPUT -s 0.0.0.0/8 -j DROP
    iptables -D OUTPUT -d 0.0.0.0/8 -j DROP
    iptables -D INPUT -s 10.0.0.0/8 -j DROP
    iptables -D OUTPUT -d 10.0.0.0/8 -j DROP
    iptables -D INPUT -s 100.64.0.0/10 -j DROP
    iptables -D OUTPUT -d 100.64.0.0/10 -j DROP
    iptables -D INPUT -s 127.0.0.0/8 -j DROP
    iptables -D OUTPUT -d 127.0.0.0/8 -j DROP
    iptables -D INPUT -s 169.254.0.0/16 -j DROP
    iptables -D OUTPUT -d 169.254.0.0/16 -j DROP
    iptables -D INPUT -s 172.16.0.0/12 -j DROP
    iptables -D OUTPUT -d 172.16.0.0/12 -j DROP
    iptables -D INPUT -s 192.0.0.0/24 -j DROP
    iptables -D OUTPUT -d 192.0.0.0/24 -j DROP
    iptables -D INPUT -s 192.0.2.0/24 -j DROP
    iptables -D OUTPUT -d 192.0.2.0/24 -j DROP
    iptables -D INPUT -s 192.88.99.0/24 -j DROP
    iptables -D OUTPUT -d 192.88.99.0/24 -j DROP
    iptables -D INPUT -s 192.168.0.0/16 -j DROP
    iptables -D OUTPUT -d 192.168.0.0/16 -j DROP
    iptables -D INPUT -s 198.18.0.0/15 -j DROP
    iptables -D OUTPUT -d 198.18.0.0/15 -j DROP
    iptables -D INPUT -s 198.51.100.0/24 -j DROP
    iptables -D OUTPUT -d 198.51.100.0/24 -j DROP
    iptables -D INPUT -s 203.0.113.0/24 -j DROP
    iptables -D OUTPUT -d 203.0.113.0/24 -j DROP
    iptables -D INPUT -s 224.0.0.0/4 -j DROP
    iptables -D OUTPUT -d 224.0.0.0/4 -j DROP
    iptables -D INPUT -s 233.252.0.0/24 -j DROP
    iptables -D OUTPUT -d 233.252.0.0/24 -j DROP
    iptables -D INPUT -s 240.0.0.0/4 -j DROP
    iptables -D OUTPUT -d 240.0.0.0/4 -j DROP
    iptables -D INPUT -s 255.255.255.255/32 -j DROP
    iptables -D OUTPUT -d 255.255.255.255/32 -j DROP

    echo "All blocked IP ranges have been released."

    rm /etc/iptables/rules.v4

    systemctl disable iptables-restore.service
    systemctl stop iptables-restore.service

    clear
    echo "All Private IP ranges have been unblocked."
    sleep 5
}

echo "Select an option:"
echo "1 - Block private IP ranges"
echo "2 - Unblock private IP ranges"
read -p "Enter your choice: " choice

case $choice in
    1)
        block_ips
        ;;
    2)
        unblock_ips
        ;;
    *)
        echo "Invalid choice."
        ;;
esac
