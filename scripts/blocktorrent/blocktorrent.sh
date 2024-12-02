#!/bin/bash
#
# Auto Block torrent list for VPN server
#
# System Required: Debian8+, Ubuntu16+, Ubuntu24+
#
# Copyright (C) 2024 Mr.Amini Nezhad
#
# my Github: https://github.com/MrAminiDev/

# Install required packages if not already installed
echo "Installing required packages..."
command -v wget >/dev/null 2>&1 || apt install -y wget
command -v curl >/dev/null 2>&1 || apt install -y curl
command -v iptables >/dev/null 2>&1 || apt install -y iptables
command -v iproute2 >/dev/null 2>&1 || apt install -y iproute2
command -v cron >/dev/null 2>&1 || apt install -y cron

# Check if iptables is installed and available
if ! command -v iptables &> /dev/null; then
    echo "iptables could not be found, installing iptables..."
    apt install -y iptables
fi

# Ensure cron is installed and enabled
if ! systemctl is-active --quiet cron; then
    echo "Starting and enabling cron service..."
    systemctl enable cron
    systemctl start cron
fi

# Download the torrent tracker list
echo -n "Blocking torrent traffic, please wait ... "
wget -q -O /etc/trackers https://raw.githubusercontent.com/MrAminiDev/NetOptix/main/scripts/blocktorrent/domains

# Create a cron job to block torrent traffic
cat >/etc/cron.daily/denypublic <<'EOF'
IFS=$'\n'
L=$(/usr/bin/sort /etc/trackers | /usr/bin/uniq)
for fn in $L; do
    /sbin/iptables -D INPUT -d $fn -j DROP
    /sbin/iptables -D FORWARD -d $fn -j DROP
    /sbin/iptables -D OUTPUT -d $fn -j DROP
    /sbin/iptables -A INPUT -d $fn -j DROP
    /sbin/iptables -A FORWARD -d $fn -j DROP
    /sbin/iptables -A OUTPUT -d $fn -j DROP
done
EOF

# Make the cron job executable
chmod +x /etc/cron.daily/denypublic

# Download the hosts file for blocking torrent traffic
curl -s -LO https://raw.githubusercontent.com/MrAminiDev/NetOptix/main/scripts/blocktorrent/hosts
cat hosts >> /etc/hosts
sort -uf /etc/hosts > /etc/hosts.uniq && mv /etc/hosts{.uniq,}

# Final message
echo "All torrent traffic blocked."
sleep 5
