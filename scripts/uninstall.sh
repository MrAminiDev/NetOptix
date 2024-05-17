cloner() {
		sed -i '/#NetOptix optimize network traffic/,/#Github: https:\/\/github.com\/MrAminiDev\//d' /etc/sysctl.conf
		sed -i '/net.ipv4.tcp_congestion_control/d' /etc/sysctl.conf
		sed -i '/net.core.default_qdisc/d' /etc/sysctl.conf
		sed -i '/net.core.optmem_max/d' /etc/sysctl.conf
		sed -i '/net.ipv4.ip_no_pmtu_disc/d' /etc/sysctl.conf
		sed -i '/net.ipv4.tcp_ecn/d' /etc/sysctl.conf
		sed -i '/net.ipv4.tcp_frto/d' /etc/sysctl.conf
		sed -i '/net.ipv4.tcp_keepalive_intvl/d' /etc/sysctl.conf
		sed -i '/net.ipv4.tcp_keepalive_probes/d' /etc/sysctl.conf
		sed -i '/net.ipv4.tcp_keepalive_time/d' /etc/sysctl.conf
		sed -i '/net.ipv4.tcp_low_latency/d' /etc/sysctl.conf
		sed -i '/net.ipv4.tcp_mtu_probing/d' /etc/sysctl.conf
		sed -i '/net.ipv4.tcp_no_metrics_save/d' /etc/sysctl.conf
		sed -i '/net.ipv4.tcp_window_scaling/d' /etc/sysctl.conf
		sed -i '/net.ipv4.tcp_sack/d' /etc/sysctl.conf
		sed -i '/net.ipv4.tcp_timestamps/d' /etc/sysctl.conf
		sed -i '/net.ipv4.tcp_delack_min/d' /etc/sysctl.conf
		sed -i '/net.ipv4.tcp_fastopen/d' /etc/sysctl.conf
		sed -i '/net.ipv4.tcp_reordering/d' /etc/sysctl.conf
		sed -i '/net.ipv4.tcp_early_retrans/d' /etc/sysctl.conf
		sed -i '/net.ipv4.tcp_ssthresh/d' /etc/sysctl.conf
		sed -i '/net.ipv4.tcp_frto_response/d' /etc/sysctl.conf
		sed -i '/net.ipv4.tcp_abort_on_overflow/d' /etc/sysctl.conf
		sed -i '/net.core.rmem_default/d' /etc/sysctl.conf
		sed -i '/net.ipv4.tcp_max_orphans/d' /etc/sysctl.conf
		sed -i '/net.ipv4.tcp_autocorking/d' /etc/sysctl.conf
		sed -i '/net.ipv4.tcp_tw_recycle/d' /etc/sysctl.conf
		sed -i '/fs.file-max/d' /etc/sysctl.conf
		sed -i '/fs.inotify.max_user_instances/d' /etc/sysctl.conf
		sed -i '/net.ipv4.tcp_tw_reuse/d' /etc/sysctl.conf
		sed -i '/net.ipv4.ip_local_port_range/d' /etc/sysctl.conf
		sed -i '/net.ipv4.tcp_rmem/d' /etc/sysctl.conf
		sed -i '/net.ipv4.tcp_wmem/d' /etc/sysctl.conf
		sed -i '/net.core.somaxconn/d' /etc/sysctl.conf
		sed -i '/net.core.rmem_max/d' /etc/sysctl.conf
		sed -i '/net.core.wmem_max/d' /etc/sysctl.conf
		sed -i '/net.core.wmem_default/d' /etc/sysctl.conf
		sed -i '/net.ipv4.tcp_max_tw_buckets/d' /etc/sysctl.conf
		sed -i '/net.ipv4.tcp_max_syn_backlog/d' /etc/sysctl.conf
		sed -i '/net.core.netdev_max_backlog/d' /etc/sysctl.conf
		sed -i '/net.ipv4.tcp_slow_start_after_idle/d' /etc/sysctl.conf
		sed -i '/net.ipv4.tcp_notsent_lowat/d' /etc/sysctl.conf
		sed -i '/net.ipv4.ip_forward/d' /etc/sysctl.conf
		sed -i '/net.ipv4.tcp_fin_timeout/d' /etc/sysctl.conf
		sed -i '/net.ipv4.tcp_mem/d' /etc/sysctl.conf
		sed -i '/net.ipv4.tcp_retries2/d' /etc/sysctl.conf
		sed -i '/net.ipv4.udp_mem/d' /etc/sysctl.conf
		sed -i '/net.unix.max_dgram_qlen/d' /etc/sysctl.conf
		sed -i '/vm.min_free_kbytes/d' /etc/sysctl.conf
		sed -i '/vm.swappiness/d' /etc/sysctl.conf
		sed -i '/vm.vfs_cache_pressure/d' /etc/sysctl.conf
		sudo sed -i 's/GRUB_CMDLINE_LINUX_DEFAULT=.*/GRUB_CMDLINE_LINUX_DEFAULT="quiet splash"/' /etc/default/grub
		sudo update-grub
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

save_config
endInstall
