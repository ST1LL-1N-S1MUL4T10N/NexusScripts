#!/bin/bash

while true; do
    clear
    echo -e "🚀 ${BLUE}NETWORKING & CONNECTIVITY 🚀${RESET}"
    echo -e "${GREEN}1) Test Internet Connection${RESET}"
    echo -e "${YELLOW}2) Get Public & Local IP${RESET}"
    echo -e "${RED}3) Scan Network for Devices${RESET}"
    echo -e "${BLUE}4) Monitor Network Bandwidth${RESET}"
    echo -e "${GREEN}5) Exit${RESET}"

    read -p "Choose an option: " choice
    
    case $choice in
        1)  
            ping -c 4 google.com
            ;;
        2)  
            echo "Public IP: $(curl -s ifconfig.me)"
            echo "Local IP: $(hostname -I)"
            ;;
        3)  
            arp -a
            ;;
        4)  
            iftop -n
            ;;
        5)  
            exit 0
            ;;
        *)  
            echo -e "${RED}Invalid option!${RESET}"
            ;;
    esac
    read -p "Press Enter to continue..."
done
