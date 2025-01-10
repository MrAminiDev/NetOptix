#!/bin/bash
#
# Auto install Swap
#
# System Required:  CentOS 6+, Debian8+, Ubuntu16+
#
# Copyright (C) 2024 Mr.Amini Nezhad
#
# my Github: https://github.com/MrAminiDev/

install_prerequisites() {
    echo "Checking for prerequisites..."
    if ! command -v modprobe &> /dev/null; then
        echo "Installing kmod package for modprobe..."
        sudo apt update && sudo apt install -y kmod
    fi
    if ! ls /lib/modules/$(uname -r)/kernel/drivers/block | grep -q zram; then
        echo "Installing ZRAM kernel module..."
        sudo apt update && sudo apt install -y linux-modules-extra-$(uname -r)
    fi
    echo "Prerequisites installed."
}

define_zram() {
    read -p "Enter the size of ZRAM in MB: " zram_size
    if [[ $zram_size =~ ^[0-9]+$ ]]; then
        if ! sudo modprobe zram; then
            echo "Error: ZRAM module could not be loaded. Please check your kernel version."
            return
        fi

        if [[ ! -e /sys/block/zram0 ]]; then
            echo "Error: ZRAM device not found."
            return
        fi

        echo "Creating ZRAM of size ${zram_size}MB..."
        sudo bash -c "echo $(($zram_size * 1024 * 1024)) > /sys/block/zram0/disksize"
        sudo mkswap /dev/zram0
        sudo swapon /dev/zram0
        echo "$zram_size" | sudo tee /etc/zram_config > /dev/null
        echo "ZRAM created and activated. Configuration saved."

        if [[ ! -f /etc/rc.local ]]; then
            echo "Creating /etc/rc.local for persistence..."
            sudo bash -c 'echo -e "#!/bin/bash\nexit 0" > /etc/rc.local'
            sudo chmod +x /etc/rc.local
        fi
        sudo sed -i '/exit 0/d' /etc/rc.local
        sudo bash -c 'cat <<EOL >> /etc/rc.local
if [[ -f /etc/zram_config ]]; then
    zram_size=\$(cat /etc/zram_config)
    modprobe zram
    echo \$((zram_size * 1024 * 1024)) > /sys/block/zram0/disksize
    mkswap /dev/zram0
    swapon /dev/zram0
fi
exit 0
EOL'
    else
        echo "Invalid size entered. Please enter a numeric value in MB."
    fi
}

restore_zram() {
    if [[ -f /etc/zram_config ]]; then
        if ! sudo modprobe zram; then
            echo "Error: ZRAM module could not be loaded."
            return
        fi

        zram_size=$(cat /etc/zram_config)
        if [[ ! -e /sys/block/zram0 ]]; then
            echo "Error: ZRAM device not found."
            return
        fi

        echo "Restoring ZRAM of size ${zram_size}MB..."
        sudo bash -c "echo $(($zram_size * 1024 * 1024)) > /sys/block/zram0/disksize"
        sudo mkswap /dev/zram0
        sudo swapon /dev/zram0
        echo "ZRAM restored and activated."
    fi
}

delete_zram() {
    sleep 2
    echo "Removing ZRAM..."
    if [[ -e /dev/zram0 ]]; then
        sudo swapoff /dev/zram0
        sudo modprobe -r zram
    fi
    sudo rm -f /etc/zram_config
    if [[ -f /etc/rc.local ]]; then
        sudo sed -i '/zram_config/,+5d' /etc/rc.local
    fi
    echo "ZRAM removed and configuration deleted."
}

display_zram_info() {
    sleep 2
    if [[ -e /sys/block/zram0 ]]; then
        disksize=$(cat /sys/block/zram0/disksize)
        mem_used=$(cat /sys/block/zram0/mem_used_total)
        echo "ZRAM Information:"
        echo "- Disk Size: $((disksize / 1024 / 1024)) MB"
        echo "- Memory Used: $((mem_used / 1024 / 1024)) MB"
    else
        echo "No active ZRAM device found."
    fi
}

install_prerequisites

restore_zram

while true; do
    echo "Choose an option:"
    echo "1 - Create ZRAM"
    echo "2 - Delete ZRAM"
    echo "3 - Display ZRAM Information"
    echo "0 - Back to Main Menu"
    read -p "Enter your choice: " choice

    case $choice in
        1)
            define_zram
            ;;
        2)
            delete_zram
            ;;
        3)
            display_zram_info
            ;;
        0)
            echo "Exiting..."
            exit 0
            ;;
        *)
            echo "Invalid option. Please choose 1, 2, 3, or q."
            ;;
    esac

done
