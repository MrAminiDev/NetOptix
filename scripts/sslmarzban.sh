#!/bin/bash
#
# Auto SSL for marzban
#
# System Required:  CentOS 6+, Debian8+, Ubuntu16+
#
# Copyright (C) 2025 Mr.Amini Nezhad
#
# my Github: https://github.com/MrAminiDev/

CERT_DIR="/var/lib/marzban/certs/"
if [ ! -d "$CERT_DIR" ]; then
    mkdir -p "$CERT_DIR"
fi

issue_ssl() {
    local domain=$1
    echo "Obtaining SSL certificate for $domain..."
    certbot certonly --standalone --agree-tos --register-unsafely-without-email -d "$domain"
    if [ $? -eq 0 ]; then
        echo "SSL certificate obtained successfully for $domain."
        cp "/etc/letsencrypt/live/$domain/fullchain.pem" "$CERT_DIR"
        cp "/etc/letsencrypt/live/$domain/privkey.pem" "$CERT_DIR"
    else
        echo "Failed to obtain SSL certificate for $domain."
        exit 1
    fi
}

setup_auto_renewal() {
    local domain=$1
    local interval=$2
    local cronjob="0 0 */$interval * * certbot renew --deploy-hook 'cp /etc/letsencrypt/live/$domain/fullchain.pem /var/lib/marzban/certs/ && cp /etc/letsencrypt/live/$domain/privkey.pem /var/lib/marzban/certs/'"
    (crontab -l 2>/dev/null; echo "$cronjob") | crontab -
    echo "Automatic renewal set up for $domain every $interval days."
}

list_domains() {
    while true; do
        clear
        echo "Domains with automatic renewal:" > /tmp/renewal_list.tmp
        crontab -l | grep "certbot renew" | while read -r line; do
            domain=$(echo "$line" | awk -F '/live/' '{print $2}' | awk -F '/' '{print $1}')
            interval=$(echo "$line" | awk -F '*/' '{print $2}' | awk '{print $1}')
            if [ -d "/etc/letsencrypt/live/$domain" ]; then
                last_renewed=$(stat -c %y "/etc/letsencrypt/live/$domain/fullchain.pem" | cut -d' ' -f1)
                next_renewal=$(date -d "$last_renewed +$interval days" +%Y-%m-%d)
                days_left=$(( ($(date -d "$next_renewal" +%s) - $(date +%s)) / 86400 ))
                echo "$domain: Renew every $interval days, $days_left days left until next renewal." >> /tmp/renewal_list.tmp
            fi
        done
        cat /tmp/renewal_list.tmp
        echo ""
        echo "Press 0 to return to the main menu."
        read -p "Enter your choice: " choice
        if [ "$choice" == "0" ]; then
            break
        fi
    done
}

delete_auto_renewals() {
    while true; do
        clear
        echo "WARNING: This will delete all automatic renewal settings for all domains."
        read -p "Are you sure you want to proceed? (yes/no): " confirmation
        if [ "$confirmation" == "yes" ]; then
            crontab -l | grep -v "certbot renew" | crontab -
            echo "All automatic renewal settings have been deleted."
            break
        elif [ "$confirmation" == "no" ]; then
            echo "Operation canceled."
            break
        else
            echo "Invalid input. Please enter 'yes' or 'no'."
        fi
    done
}

while true; do
    clear
    echo "1- Normal SSL Marzban"
    echo "2- Auto SSL Marzban"
    echo "3- List Domains with Auto SSL"
    echo "4- Delete All Auto SSL Settings"
    echo "0- Exit"
    read -p "Choose an option: " choice

    case $choice in
        1)
            read -p "Enter your domain: " domain
            issue_ssl "$domain"
            ;;
        2)
            read -p "Enter your domain: " domain
            while true; do
                read -p "How often should SSL be renewed? (Enter in days Min 10 Day max 60 day): " days
                if [[ $days -ge 10 && $days -le 60 ]]; then
                    issue_ssl "$domain"
                    setup_auto_renewal "$domain" "$days"
                    break
                else
                    echo "Invalid input. Please enter a value between 10 and 60."
                fi
            done
            ;;
        3)
            list_domains
            ;;
        4)
            delete_auto_renewals
            ;;
        0)
            echo "Exiting..."
            exit 0
            ;;
        *)
            echo "Invalid option. Please try again."
            ;;
    esac

done
