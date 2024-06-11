#!/bin/bash
#
# Auto install Finder MTU
#
# System Required:  CentOS 6+, Debian8+, Ubuntu16+
#
# Copyright (C) 2024 Mr.Amini Nezhad
#
# my Github: https://github.com/MrAminiDev/

check_requirements() {
    local requirements=("ping" "ping6" "ip")

    for req in "${requirements[@]}"; do
        if ! command -v $req &> /dev/null; then
            echo "$req is required, installing..."
            sudo apt-get update
            sudo apt-get install -y $req
        fi
    done
}

show_menu() {
    echo "Select IP type:"
    echo "1- IPv4"
    echo "2- IPv6"
    read -p "Enter choice [1-2]: " ip_type

    if [[ $ip_type -ne 1 && $ip_type -ne 2 ]]; then
        echo "Invalid choice. Exiting."
        exit 1
    fi

    read -p "Enter destination IP: " dest_ip

    if [[ -z $dest_ip ]]; then
        echo "No IP entered. Exiting."
        exit 1
    fi
}

find_max_mtu() {
    local ip=$1
    local proto=$2
    local interface="eth0" 
    local min_mtu=1000
    local max_mtu=1500
    local current_mtu=$min_mtu
    local last_successful_mtu=$min_mtu

    echo "Starting MTU discovery for $proto on $ip..."

    while [[ $current_mtu -le $max_mtu ]]; do
        echo -n "Testing MTU: $current_mtu... "
        if [[ $proto == "IPv4" ]]; then
            ping -M do -c 1 -s $((current_mtu - 28)) $ip &> /dev/null
        else
            ping6 -M do -c 1 -s $((current_mtu - 48)) $ip &> /dev/null
        fi

        if [[ $? -eq 0 ]]; then
            echo "Success"
            last_successful_mtu=$current_mtu
        else
            echo "Failed"
            break
        fi

        ((current_mtu+=10))
    done

    echo "The maximum MTU for $proto on $ip is: $last_successful_mtu"

    echo "Setting MTU $last_successful_mtu on interface $interface..."
    sudo ip link set dev $interface mtu $last_successful_mtu

    if [[ $? -eq 0 ]]; then
        echo "MTU successfully set to $last_successful_mtu on $interface."
    else
        echo "Failed to set MTU on $interface."
    fi
}

endInstall() {
    clear
    echo "The script was successfully Install and Fix MTU Size."
    read -p "Press Enter to continue..."
}


main() {
    check_requirements

    show_menu

    if [[ $ip_type -eq 1 ]]; then
        find_max_mtu $dest_ip "IPv4"
    else
        find_max_mtu $dest_ip "IPv6"
    fi
	
	sleep 3
	
	endInstall
}

main