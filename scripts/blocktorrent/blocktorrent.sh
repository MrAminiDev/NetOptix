#!/bin/bash
#
# Auto Block torrent list fot VPN server
#
# System Required: Debian8+, Ubuntu16+
#
# Copyright (C) 2024 Mr.Amini Nezhad
#
# my Github: https://github.com/MrAminiDev/

echo -n "Blocking torrent traffic, please wait ... "
wget -q -O/etc/trackers https://raw.githubusercontent.com/MrAminiDev/NetOptix/main/scripts/blocktorrent/domains
cat >/etc/cron.daily/denypublic<<'EOF'
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
chmod +x /etc/cron.daily/denypublic
curl -s -LO https://raw.githubusercontent.com/MrAminiDev/NetOptix/main/scripts/blocktorrent/hosts
cat Thosts >> /etc/hosts
sort -uf /etc/hosts > /etc/hosts.uniq && mv /etc/hosts{.uniq,}
echo "${OK}"
