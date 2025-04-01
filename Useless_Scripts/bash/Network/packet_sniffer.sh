#!/bin/bash
# 🛠️ Packet Sniffer Automation Script
# Automates packet sniffing using tcpdump with an interactive and user-friendly interface.

# 🎨 Define Colors for Output
GREEN="\e[32m"
YELLOW="\e[33m"
RED="\e[31m"
BLUE="\e[34m"
RESET="\e[0m"

# 🛠️ Function to install tcpdump if missing
install_tcpdump() {
    if ! command -v tcpdump &>/dev/null; then
        echo -e "${YELLOW}⚠️  tcpdump is not installed. Installing...${RESET}"
        sudo apt update && sudo apt install -y tcpdump
        if ! command -v tcpdump &>/dev/null; then
            echo -e "${RED}❌ Failed to install tcpdump. Exiting...${RESET}"
            exit 1
        fi
        echo -e "${GREEN}✅ tcpdump installed successfully.${RESET}"
    fi
}

# 🌐 Function to list and select network interface
select_interface() {
    echo -e "${BLUE}🔍 Available network interfaces:${RESET}"
    ip -o link show | awk -F': ' '{print $2}' | nl
    echo -e "${YELLOW}ℹ️  Enter the number corresponding to your interface:${RESET}"
    read -p "➜ " iface_num
    iface=$(ip -o link show | awk -F': ' '{print $2}' | sed -n "${iface_num}p")
    
    if [[ -z "$iface" ]]; then
        echo -e "${RED}❌ Invalid selection. Please try again.${RESET}"
        select_interface
    fi
}

# ⏳ Function to get valid capture duration
get_duration() {
    read -p "⏳ Enter capture duration in seconds: " duration
    if ! [[ "$duration" =~ ^[0-9]+$ ]]; then
        echo -e "${RED}❌ Invalid duration! Please enter a positive number.${RESET}"
        get_duration
    fi
}

# 🏁 Main script execution
echo -e "${GREEN}=== 🛠️ Packet Sniffer Automation ===${RESET}"

# 🔍 Ensure tcpdump is installed
install_tcpdump

# 🌐 Let the user select a network interface
select_interface
echo -e "${GREEN}✅ Selected interface: $iface${RESET}"

# ⏳ Get capture duration
get_duration
echo -e "${GREEN}✅ Capture duration: $duration seconds${RESET}"

# 📁 Generate output filename
output_file="capture_$(date +%Y%m%d_%H%M%S).pcap"

# 🚀 Start packet capture
echo -e "${BLUE}🚀 Starting packet capture on $iface for $duration seconds...${RESET}"
sudo timeout "$duration" tcpdump -i "$iface" -w "$output_file" &

# ⏳ Display a countdown while capturing packets
for ((i=duration; i>0; i--)); do
    echo -ne "${YELLOW}⏳ Capturing packets... $i seconds remaining...\r${RESET}"
    sleep 1
done
echo -e "\n${GREEN}✅ Capture completed!${RESET}"

# 📁 Check if the capture file was created successfully
if [[ -f "$output_file" ]]; then
    echo -e "${GREEN}📁 Capture saved to: ${BLUE}$output_file${RESET}"
else
    echo -e "${RED}❌ Error: Capture failed or was interrupted.${RESET}"
    exit 1
fi
