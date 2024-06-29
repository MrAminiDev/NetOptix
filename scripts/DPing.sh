#!/bin/bash
#
# Auto Disable ping server
#
# System Required: Debian8+, Ubuntu16+
#
# Copyright (C) 2024 Mr.Amini Nezhad
#
# my Github: https://github.com/MrAminiDev/

sudo apt-get update
sudo apt-get install -y iptables-persistent

sudo iptables -A INPUT -p icmp --icmp-type echo-request -j DROP

sudo netfilter-persistent save

echo "Ping requests have been blocked."

sleep 5
