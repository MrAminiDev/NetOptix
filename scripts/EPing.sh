#!/bin/bash
#
# Auto Disable ping server
#
# System Required: Debian8+, Ubuntu16+
#
# Copyright (C) 2024 Mr.Amini Nezhad
#
# my Github: https://github.com/MrAminiDev/

sudo iptables -D INPUT -p icmp --icmp-type echo-request -j DROP

sudo sh -c "iptables-save > /etc/iptables/rules.v4"

echo "Ping requests have been unblocked."

sleep 5
