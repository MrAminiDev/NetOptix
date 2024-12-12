#!/bin/bash
#
# Auto install Finder MTU
#
# System Required:  CentOS 6+, Debian8+, Ubuntu16+
#
# Copyright (C) 2024 Mr.Amini Nezhad
#
# my Github: https://github.com/MrAminiDev/


#!/bin/bash

check_requirements() {
    local requirements=("ping" "ping6" "ip" "netplan" "net-tools")
    echo "Checking required packages..."

    for req in "${requirements[@]}"; do
        if ! command -v $req &> /dev/null; then
            echo "$req is not installed. Installing..."
            sudo apt-get update
            sudo apt-get install -y $req
        fi
    done
    echo "All required packages are installed."
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

    read -p "Is the default network interface eth0? (In Hezner datacenter, the default is eth0) [Y/N]: " default_iface

    if [[ $default_iface == "Y" || $default_iface == "y" ]]; then
        interface="eth0"
    elif [[ $default_iface == "N" || $default_iface == "n" ]]; then
        read -p "Enter network interface (e.g., eth0): " interface
        if [[ -z $interface ]]; then
            echo "No interface entered. Exiting."
            exit 1
        fi
    else
        echo "Invalid choice. Exiting."
        exit 1
    fi

    while true; do
        read -p "Enter incremental step (1-10): " step_size
        if [[ $step_size -ge 1 && $step_size -le 10 ]]; then
            break
        else
            echo "Invalid step size. Please enter a number between 1 and 10."
        fi
    done
}

save_mtu_setting() {
    local interface=$1
    local mtu=$2

    if [[ -f "/etc/netplan/01-netcfg.yaml" || -f "/etc/netplan/50-cloud-init.yaml" ]]; then
        local netplan_file=$(ls /etc/netplan/*.yaml | head -n 1)
        echo "Updating $netplan_file for permanent MTU setting..."
        sudo sed -i "/^ *ethernets:/,/^ *vlans:/ s/^ *$interface:/&\n      mtu: $mtu/" $netplan_file
        sudo netplan apply
    elif [[ -f "/etc/network/interfaces" ]]; then
        echo "Updating /etc/network/interfaces for permanent MTU setting..."
        sudo sed -i "/iface $interface inet/ a \    mtu $mtu" /etc/network/interfaces
        sudo ifdown $interface && sudo ifup $interface
    else
        echo "Could not detect Netplan or ifupdown. Please update manually."
        exit 1
    fi
}

find_max_mtu() {
    local ip=$1
    local proto=$2
    local interface=$3
    local step_size=$4
    local min_mtu=1000
    local max_mtu=1500
    local last_successful_mtu=$max_mtu

    echo "Starting MTU discovery for $proto on $ip..."

    echo "Setting MTU to $max_mtu on interface $interface..."
    sudo ip link set dev $interface mtu $max_mtu

    if [[ $? -ne 0 ]]; then
        echo "Failed to set initial MTU on $interface. Exiting."
        exit 1
    fi

    local current_mtu=$min_mtu

    while [[ $current_mtu -le $max_mtu ]]; do
        echo -n "Testing MTU: $current_mtu... "
        if [[ $proto == "IPv4" ]]; then
            ping -M do -c 1 -s $((current_mtu - 28)) $ip -W 1 &> /dev/null
        else
            ping6 -M do -c 1 -s $((current_mtu - 48)) $ip -W 1 &> /dev/null
        fi

        if [[ $? -eq 0 ]]; then
            echo "Success"
            last_successful_mtu=$current_mtu
        else
            echo "Failed"
            echo "Re-testing MTU: $current_mtu... "
            if [[ $proto == "IPv4" ]]; then
                ping -M do -c 1 -s $((current_mtu - 28)) $ip -W 1 &> /dev/null
            else
                ping6 -M do -c 1 -s $((current_mtu - 48)) $ip -W 1 &> /dev/null
            fi

            if [[ $? -ne 0 ]]; then
                break
            else
                last_successful_mtu=$current_mtu
            fi
        fi

        ((current_mtu+=step_size))
        sleep 1
    done

    local final_mtu=$((last_successful_mtu - 2))

    echo "The maximum MTU for $proto on $ip is: $last_successful_mtu"
    echo "Setting MTU to $final_mtu on interface $interface..."
    sudo ip link set dev $interface mtu $final_mtu

    if [[ $? -eq 0 ]]; then
        echo "MTU successfully set to $final_mtu on $interface."
        save_mtu_setting $interface $final_mtu
    else
        echo "Failed to set MTU on $interface."
    fi
}

main() {
    check_requirements

    show_menu

    if [[ $ip_type -eq 1 ]]; then
        find_max_mtu $dest_ip "IPv4" $interface $step_size
    else
        find_max_mtu $dest_ip "IPv6" $interface $step_size
    fi
}

main
