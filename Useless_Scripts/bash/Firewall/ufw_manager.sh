#!/bin/bash
# 🔥 Ultimate UFW Firewall Manager - Interactive & Feature-Rich Firewall Control

# 🎨 Define Colors for Output
GREEN="\e[32m"
YELLOW="\e[33m"
RED="\e[31m"
BLUE="\e[34m"
CYAN="\e[36m"
RESET="\e[0m"

# 🔍 Function to check if UFW is installed and install if missing
install_ufw() {
    if ! command -v ufw &>/dev/null; then
        echo -e "${YELLOW}⚠️  UFW is not installed. Installing...${RESET}"
        sudo apt update && sudo apt install -y ufw
        if ! command -v ufw &>/dev/null; then
            echo -e "${RED}❌ Failed to install UFW. Exiting...${RESET}"
            exit 1
        fi
        echo -e "${GREEN}✅ UFW installed successfully.${RESET}"
    fi
}

# 🔥 Function to show UFW status
show_ufw_status() {
    echo -e "${BLUE}🔥 Current UFW Status:${RESET}"
    sudo ufw status verbose || echo -e "${RED}❌ Unable to retrieve UFW status.${RESET}"
}

# 🎛️ Function to enable or disable UFW
toggle_ufw() {
    read -p "⚡ Do you want to (E)nable or (D)isable UFW? (e/d): " choice
    case "$choice" in
        [Ee]) sudo ufw enable && echo -e "${GREEN}✅ UFW Enabled.${RESET}" ;;
        [Dd]) sudo ufw disable && echo -e "${RED}🚫 UFW Disabled.${RESET}" ;;
        *) echo -e "${RED}❌ Invalid option. Returning to menu.${RESET}" ;;
    esac
}

# ➕ Function to add a new firewall rule
add_ufw_rule() {
    read -p "🛑 Enter the port number to allow: " port
    if ! [[ "$port" =~ ^[0-9]+$ ]] || (( port < 1 || port > 65535 )); then
        echo -e "${RED}❌ Invalid port number. Please enter a value between 1-65535.${RESET}"
        add_ufw_rule
        return
    fi

    # Ask for protocol (TCP/UDP)
    read -p "🌐 Allow for TCP, UDP, or both? (tcp/udp/both): " protocol
    case "$protocol" in
        tcp) proto="tcp";;
        udp) proto="udp";;
        both) proto="";;
        *) echo -e "${RED}❌ Invalid option. Defaulting to both protocols.${RESET}"; proto="";;
    esac

    # Ask for optional IP restriction
    read -p "🔒 Restrict access to a specific IP (leave blank for any): " ip
    rule="ufw allow $port"

    if [[ -n "$proto" ]]; then
        rule+="/$proto"
    fi

    if [[ -n "$ip" ]]; then
        rule+=" from $ip"
    fi

    # Apply the rule
    echo -e "${YELLOW}⚡ Applying rule: ${BLUE}$rule${RESET}"
    sudo $rule && echo -e "${GREEN}✅ Rule added successfully!${RESET}" || echo -e "${RED}❌ Failed to add rule.${RESET}"
}

# ❌ Function to delete a firewall rule
delete_ufw_rule() {
    echo -e "${CYAN}📜 Listing current rules:${RESET}"
    sudo ufw status numbered
    read -p "❌ Enter the rule number to delete: " rule_num
    if ! [[ "$rule_num" =~ ^[0-9]+$ ]]; then
        echo -e "${RED}❌ Invalid rule number. Returning to menu.${RESET}"
        return
    fi
    sudo ufw delete "$rule_num" && echo -e "${GREEN}✅ Rule deleted successfully!${RESET}" || echo -e "${RED}❌ Failed to delete rule.${RESET}"
}

# 🔄 Function to reset UFW rules
reset_ufw() {
    read -p "⚠️  Are you sure you want to reset all rules? (y/n): " confirm
    if [[ "$confirm" =~ ^[Yy]$ ]]; then
        sudo ufw reset && echo -e "${GREEN}✅ UFW rules reset successfully.${RESET}"
    else
        echo -e "${YELLOW}ℹ️  Reset cancelled.${RESET}"
    fi
}

# 📜 Function to show UFW logs
show_ufw_logs() {
    echo -e "${CYAN}📜 Last 10 blocked connections:${RESET}"
    sudo dmesg | grep 'UFW BLOCK' | tail -10 || echo -e "${RED}❌ No blocked connection logs found.${RESET}"
}

# 📌 Main Menu
main_menu() {
    while true; do
        echo -e "${GREEN}\n=== 🔥 UFW Firewall Manager ===${RESET}"
        echo -e "${BLUE}1) View UFW Status${RESET}"
        echo -e "${BLUE}2) Enable/Disable UFW${RESET}"
        echo -e "${BLUE}3) Add a New Rule${RESET}"
        echo -e "${BLUE}4) Delete a Rule${RESET}"
        echo -e "${BLUE}5) Reset All Rules${RESET}"
        echo -e "${BLUE}6) View Blocked Logs${RESET}"
        echo -e "${BLUE}7) Exit${RESET}"

        read -p "🔹 Select an option: " option
        case "$option" in
            1) show_ufw_status ;;
            2) toggle_ufw ;;
            3) add_ufw_rule ;;
            4) delete_ufw_rule ;;
            5) reset_ufw ;;
            6) show_ufw_logs ;;
            7) echo -e "${GREEN}🚀 Exiting...${RESET}"; exit 0 ;;
            *) echo -e "${RED}❌ Invalid option. Please try again.${RESET}" ;;
        esac
    done
}

# 🚀 Start the script
install_ufw
main_menu
