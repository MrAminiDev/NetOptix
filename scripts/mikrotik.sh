#!/bin/bash
# Auto install mikrotik on ubuntu
#
# System Required:  CentOS 6+, Debian8+, Ubuntu16+
#
# Copyright (C) 2024 Mr.Amini Nezhad
#
# my Github: https://github.com/MrAminiDev/

# Define colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[38;5;68m'
GREEN_ALT='\033[38;5;35m'
YELLOW='\033[1;33m'
NC='\033[0m'

clear

# Step 1: Select MikroTik version
echo -e "${YELLOW}Please select the MikroTik version to install:${NC}"
echo "1) 7.14.3"
echo "2) 7.9"
echo "3) 7.7"
echo "4) 6.49.15"
echo "5) 6.49.13"
read -p "Enter the number corresponding to your choice: " version_choice

case $version_choice in
    1) version="7.14.3";;
    2) version="7.9";;
    3) version="7.7";;
    4) version="6.49.15";;
    5) version="6.49.13";;
    *) echo -e "${RED}Invalid choice. Exiting.${NC}"; exit 1;;
esac

echo -e "${GREEN_ALT}You have selected version ${version}.${NC}"

# Step 2: Install required packages
echo -e "${YELLOW}Step 1: Installing required packages...${NC}"
sudo apt-get update && sudo apt-get install -y kpartx
if [ $? -ne 0 ]; then
    echo -e "${RED}Failed to install required packages. Exiting.${NC}"
    exit 1
fi
echo -e "${GREEN_ALT}Required packages installed.${NC}"

# Step 3: Download MikroTik installation file
echo -e "${YELLOW}Step 2: Downloading MikroTik installation file...${NC}"
wget "https://download.mikrotik.com/routeros/${version}/chr-${version}.img.zip" -O chr.img.zip > /dev/null 2>&1
if [ $? -ne 0 ]; then
    echo -e "${RED}Failed to download MikroTik installation file. Exiting.${NC}"
    exit 1
fi
echo -e "${GREEN_ALT}MikroTik installation file downloaded.${NC}"

# Step 4: Extract installation file
echo -e "${YELLOW}Step 3: Extracting MikroTik installation file...${NC}"
gunzip -c chr.img.zip > chr.img
if [ $? -ne 0 ]; then
    echo -e "${RED}Failed to extract MikroTik installation file. Exiting.${NC}"
    exit 1
fi
echo -e "${GREEN_ALT}MikroTik installation file extracted.${NC}"

# Step 5: Set up loop device
echo -e "${YELLOW}Step 4: Setting up loop device and partitions...${NC}"
LOOP_DEVICE=$(sudo losetup -f --show chr.img)
if [ $? -ne 0 ]; then
    echo -e "${RED}Failed to set up loop device. Exiting.${NC}"
    exit 1
fi

sudo kpartx -a $LOOP_DEVICE > /dev/null 2>&1
if [ $? -ne 0 ]; then
    echo -e "${RED}Failed to set up partitions. Exiting.${NC}"
    exit 1
fi
echo -e "${GREEN_ALT}Loop device set up at ${LOOP_DEVICE}.${NC}"

# Step 6: Mount installation image
echo -e "${YELLOW}Step 5: Mounting MikroTik installation image...${NC}"
sudo mount /dev/mapper/$(basename ${LOOP_DEVICE})p1 /mnt > /dev/null 2>&1
if [ $? -ne 0 ]; then
    echo -e "${RED}Failed to mount installation image. Exiting.${NC}"
    exit 1
fi
echo -e "${GREEN_ALT}Installation image mounted.${NC}"

# Step 7: Configure network settings
echo -e "${YELLOW}Step 6: Configuring network settings...${NC}"
INTERFACE=$(ip route | grep default | awk '{print $5}')
ADDRESS=$(ip addr show $INTERFACE | grep global | cut -d' ' -f 6 | head -n 1)
GATEWAY=$(ip route list | grep default | cut -d' ' -f 3)

if [ -z "$ADDRESS" ] || [ -z "$GATEWAY" ]; then
    echo -e "${RED}Failed to configure network settings. Exiting.${NC}"
    exit 1
fi
echo -e "${GREEN_ALT}Network settings configured. IP Address: $ADDRESS, Gateway: $GATEWAY${NC}"

# Step 8: Identify storage device
echo -e "${YELLOW}Step 7: Identifying storage device...${NC}"
DISK_DEVICE=$(fdisk -l | grep "^Disk /dev" | grep -v "^Disk /dev/loop" | cut -d' ' -f2 | tr -d ':')
if [ -z "$DISK_DEVICE" ]; then
    echo -e "${RED}No suitable storage device found. Exiting.${NC}"
    exit 1
fi
echo -e "${GREEN_ALT}Using storage device: $DISK_DEVICE${NC}"

# Step 9: Write to disk
echo -e "${YELLOW}Step 8: Syncing disk...${NC}"
sudo dd if=chr.img bs=1024 of=$DISK_DEVICE status=progress
if [ $? -ne 0 ]; then
    echo -e "${RED}Failed to prepare disk for installation. Exiting.${NC}"
    exit 1
fi
sudo sync

# Cleanup
rm -f chr.img.zip > /dev/null 2>&1
sudo umount /mnt > /dev/null 2>&1
sudo kpartx -d $LOOP_DEVICE
sudo losetup -d $LOOP_DEVICE

# Completion message
echo -e "${GREEN_ALT}-------------------------------------------"
echo -e "${GREEN_ALT}  Installation completed successfully!     ${NC}"
echo -e "${GREEN_ALT}  Your MikroTik installation is ready.     ${NC}"
echo -e "${GREEN_ALT}-------------------------------------------${NC}"

# Optional reboot hint
echo -e "${YELLOW}Booting...${NC}"
echo -e "${GREEN_ALT}If Mikrotik not booted, Power reboot VPS from Panel.${NC}"
echo b | sudo tee /proc/sysrq-trigger > /dev/null 2>&1
