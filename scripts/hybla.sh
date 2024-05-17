#!/bin/bash
#
# Auto install latest kernel for TCP Hybla
#
# System Required:  CentOS 6+, Debian8+, Ubuntu16+
#
# Copyright (C) 2024 Mr.Amini Nezhad
#
# my Github: https://github.com/MrAminiDev/


display_menu() {
    if [ $EUID -ne 0 ]; then
        _error "This script must be run as root"
    fi
    opsy=$(_os_full)
    arch=$(uname -m)
    lbit=$(getconf LONG_BIT)
    kern=$(uname -r)

    clear
    echo "---------- System Information ----------"
    echo " OS      : $opsy"
    echo " Arch    : $arch ($lbit Bit)"
    echo " Kernel  : $kern"
    echo "----------------------------------------"
    echo "Automatically enable TCP Hybla script"
    echo
    echo "Coded By: https://github.com/MrAminiDev/"
    echo "----------------------------------------"
    echo "Press any key to start...or Press Ctrl+C to cancel"
    read -s -n 1 key
}


_os_full() {
    [ -f /etc/redhat-release ] && awk '{print ($1,$3~/^[0-9]/?$3:$4)}' /etc/redhat-release && return
    [ -f /etc/os-release ] && awk -F'[= "]' '/PRETTY_NAME/{print $3,$4,$5}' /etc/os-release && return
    [ -f /etc/lsb-release ] && awk -F'[="]+' '/DESCRIPTION/{print $2}' /etc/lsb-release && return
}

# Function to check the system
check_sys() {
    if [[ -f /etc/redhat-release ]]; then
        release="centos"
    elif cat /etc/issue | grep -q -E -i "debian"; then
        release="debian"
    elif cat /etc/issue | grep -q -E -i "ubuntu"; then
        release="ubuntu"
    elif cat /etc/issue | grep -q -E -i "centos|red hat|redhat"; then
        release="centos"
    elif cat /proc/version | grep -q -E -i "debian"; then
        release="debian"
    elif cat /proc/version | grep -q -E -i "ubuntu"; then
        release="ubuntu"
    elif cat /proc/version | grep -q -E -i "centos|red hat|redhat"; then
        release="centos"
    fi
}

# Function to check the system version and bit
check_version() {
    if [[ -s /etc/redhat-release ]]; then
        version=$(grep -oE "[0-9.]+" /etc/redhat-release | cut -d . -f 1)
    else
        version=$(grep -oE "[0-9.]+" /etc/issue | cut -d . -f 1)
    fi
    bit=$(uname -m)
    if [[ ${bit} == "x86_64" ]]; then
        bit="x64"
    else
        bit="x32"
    fi
}


sysctl_config() {
		echo -e "#NetOptix optimize network traffic\n#Github: https://github.com/MrAminiDev//\n" > /etc/sysctl.conf
		echo "net.ipv4.tcp_congestion_control = hybla" >> /etc/sysctl.conf
		echo "net.core.default_qdisc = fq_codel" >> /etc/sysctl.conf
		echo "net.core.optmem_max = 65535" >> /etc/sysctl.conf
		echo "net.ipv4.ip_no_pmtu_disc = 1" >> /etc/sysctl.conf
		echo "net.ipv4.tcp_ecn = 2" >> /etc/sysctl.conf
		echo "net.ipv4.tcp_frto = 2" >> /etc/sysctl.conf
		echo "net.ipv4.tcp_keepalive_intvl = 30" >> /etc/sysctl.conf
		echo "net.ipv4.tcp_keepalive_probes = 3" >> /etc/sysctl.conf
		echo "net.ipv4.tcp_keepalive_time = 300" >> /etc/sysctl.conf
		echo "net.ipv4.tcp_low_latency = 1" >> /etc/sysctl.conf
		echo "net.ipv4.tcp_mtu_probing = 1" >> /etc/sysctl.conf
		echo "net.ipv4.tcp_no_metrics_save = 1" >> /etc/sysctl.conf
		echo "net.ipv4.tcp_window_scaling = 1" >> /etc/sysctl.conf
		echo "net.ipv4.tcp_sack = 1" >> /etc/sysctl.conf
		echo "net.ipv4.tcp_timestamps = 1" >> /etc/sysctl.conf
		echo "net.ipv4.tcp_delack_min = 5" >> /etc/sysctl.conf
		echo "net.ipv4.tcp_fastopen = 3" >> /etc/sysctl.conf
		echo "net.ipv4.tcp_reordering = 3" >> /etc/sysctl.conf
		echo "net.ipv4.tcp_early_retrans = 3" >> /etc/sysctl.conf
		echo "net.ipv4.tcp_ssthresh = 32768" >> /etc/sysctl.conf
		echo "net.ipv4.tcp_frto_response = 2" >> /etc/sysctl.conf
		echo "net.ipv4.tcp_abort_on_overflow = 1" >> /etc/sysctl.conf
		echo "net.core.rmem_default = 4194304" >> /etc/sysctl.conf
		echo "net.ipv4.tcp_max_orphans = 3276800" >> /etc/sysctl.conf
		echo "net.ipv4.tcp_autocorking = 1" >> /etc/sysctl.conf
		echo "net.ipv4.tcp_tw_recycle = 1" >> /etc/sysctl.conf
		echo "fs.file-max = 1000000" >> /etc/sysctl.conf
		echo "fs.inotify.max_user_instances = 8192" >> /etc/sysctl.conf
		echo "net.ipv4.tcp_tw_reuse = 1" >> /etc/sysctl.conf
		echo "net.ipv4.ip_local_port_range = 75 65535" >> /etc/sysctl.conf
		echo "net.ipv4.tcp_rmem = 16384 262144 8388608" >> /etc/sysctl.conf
		echo "net.ipv4.tcp_wmem = 32768 524288 16777216" >> /etc/sysctl.conf
		echo "net.core.somaxconn = 8192" >> /etc/sysctl.conf
		echo "net.core.rmem_max = 16777216" >> /etc/sysctl.conf
		echo "net.core.wmem_max = 16777216" >> /etc/sysctl.conf
		echo "net.core.wmem_default = 2097152" >> /etc/sysctl.conf
		echo "net.ipv4.tcp_max_tw_buckets = 5000" >> /etc/sysctl.conf
		echo "net.ipv4.tcp_max_syn_backlog = 10240" >> /etc/sysctl.conf
		echo "net.core.netdev_max_backlog = 10240" >> /etc/sysctl.conf
		echo "net.ipv4.tcp_slow_start_after_idle = 0" >> /etc/sysctl.conf
		echo "net.ipv4.tcp_notsent_lowat = 16384" >> /etc/sysctl.conf
		echo "net.ipv4.ip_forward = 1" >> /etc/sysctl.conf
		echo "net.ipv4.tcp_fin_timeout = 25" >> /etc/sysctl.conf
		echo "net.ipv4.tcp_mem = 65536 131072 262144" >> /etc/sysctl.conf
		echo "net.ipv4.tcp_retries2 = 8" >> /etc/sysctl.conf
		echo "net.ipv4.udp_mem = 65536 131072 262144" >> /etc/sysctl.conf
		echo "net.unix.max_dgram_qlen = 50" >> /etc/sysctl.conf
		echo "vm.min_free_kbytes = 65536" >> /etc/sysctl.conf
		echo "vm.swappiness = 10" >> /etc/sysctl.conf
		echo "vm.vfs_cache_pressure = 50" >> /etc/sysctl.conf
		echo "ulimit -SHn 1000000">>/etc/profile
		sudo sysctl -p
		sudo sysctl --system
}


save_config() {
    sudo sysctl -p
    sudo sysctl --system
}
endInstall() {
    clear
    echo "The script was successfully uninstalled and all settings were removed"
	read -p "Press Enter to continue..."
	xdg-open https://raw.githubusercontent.com/MrAminiDev/NetOptix/main/NetOptix.sh
}

display_menu
run_drop_caches
check_sys
check_version
sysctl_config
save_config
endInstall
