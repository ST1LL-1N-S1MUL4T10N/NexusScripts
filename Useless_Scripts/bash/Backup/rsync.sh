#!/bin/bash
# 🔄 Ultimate File Synchronization Tool - Powered by rsync

# 🎨 Define Colors for Output
GREEN="\e[32m"
YELLOW="\e[33m"
RED="\e[31m"
BLUE="\e[34m"
CYAN="\e[36m"
RESET="\e[0m"

# 📌 Ensure rsync is installed
install_rsync() {
    if ! command -v rsync &>/dev/null; then
        echo -e "${YELLOW}⚠️ rsync is not installed. Installing...${RESET}"
        sudo apt update && sudo apt install -y rsync
        if ! command -v rsync &>/dev/null; then
            echo -e "${RED}❌ Failed to install rsync. Exiting...${RESET}"
            exit 1
        fi
        echo -e "${GREEN}✅ rsync installed successfully.${RESET}"
    fi
}

# 📂 Select source and destination directories
select_directories() {
    read -p "📂 Enter source directory: " src
    if [[ ! -d "$src" ]]; then
        echo -e "${RED}❌ Source directory does not exist.${RESET}"
        return 1
    fi

    read -p "📂 Enter destination directory: " dest
    mkdir -p "$dest"  # Ensure destination exists

    if [[ ! -d "$dest" ]]; then
        echo -e "${RED}❌ Failed to create/access destination directory.${RESET}"
        return 1
    fi
}

# 🔄 Choose synchronization mode
select_sync_mode() {
    echo -e "${CYAN}\n🔄 Select Synchronization Mode:${RESET}"
    echo -e "${BLUE}1) Normal Sync (Copy files without deletion)${RESET}"
    echo -e "${BLUE}2) Mirror Sync (Exact copy, deletes extras in destination)${RESET}"
    echo -e "${BLUE}3) Incremental Backup (Only copy newer files)${RESET}"

    read -p "🔹 Enter your choice: " mode
    case "$mode" in
        1) SYNC_MODE="-avh"; echo -e "${GREEN}✅ Normal Sync Selected.${RESET}" ;;
        2) SYNC_MODE="-avh --delete"; echo -e "${GREEN}✅ Mirror Sync Selected.${RESET}" ;;
        3) SYNC_MODE="-avh --update"; echo -e "${GREEN}✅ Incremental Backup Selected.${RESET}" ;;
        *) echo -e "${RED}❌ Invalid choice. Defaulting to Normal Sync.${RESET}"; SYNC_MODE="-avh" ;;
    esac
}

# 🚀 Ask if user wants to do a dry run
confirm_dry_run() {
    read -p "👀 Perform a dry run first? (y/n): " dry_run
    if [[ "$dry_run" =~ ^[Yy]$ ]]; then
        SYNC_MODE+=" --dry-run"
        echo -e "${YELLOW}📝 Running in Dry Run mode. No files will be changed.${RESET}"
    fi
}

# 📡 Set optional bandwidth limit
set_bandwidth_limit() {
    read -p "🚀 Set a bandwidth limit (KB/s) or press Enter for unlimited: " limit
    if [[ "$limit" =~ ^[0-9]+$ ]]; then
        SYNC_MODE+=" --bwlimit=$limit"
        echo -e "${GREEN}✅ Bandwidth limited to ${limit}KB/s.${RESET}"
    else
        echo -e "${YELLOW}⚠️ No bandwidth limit set.${RESET}"
    fi
}

# 📜 Enable logging
enable_logging() {
    LOG_FILE="sync_log_$(date +%F_%T).log"
    read -p "📜 Save sync logs to $LOG_FILE? (y/n): " log_choice
    if [[ "$log_choice" =~ ^[Yy]$ ]]; then
        SYNC_MODE+=" --log-file=$LOG_FILE"
        echo -e "${GREEN}✅ Logging enabled. Sync details will be saved.${RESET}"
    fi
}

# 🚀 Perform synchronization
sync_files() {
    echo -e "${YELLOW}⚡ Starting file synchronization...${RESET}"
    rsync $SYNC_MODE "$src/" "$dest/"
    if [[ $? -eq 0 ]]; then
        echo -e "${GREEN}✅ Synchronization complete!${RESET}"
    else
        echo -e "${RED}❌ rsync failed.${RESET}"
    fi
}

# 📌 Main Menu
main_menu() {
    while true; do
        echo -e "${GREEN}\n=== 🔄 File Synchronization Tool ===${RESET}"
        echo -e "${BLUE}1) Start a New Sync${RESET}"
        echo -e "${BLUE}2) Exit${RESET}"

        read -p "🔹 Select an option: " option
        case "$option" in
            1) 
                if select_directories; then
                    select_sync_mode
                    confirm_dry_run
                    set_bandwidth_limit
                    enable_logging
                    sync_files
                fi
                ;;
            2) echo -e "${GREEN}🚀 Exiting...${RESET}"; exit 0 ;;
            *) echo -e "${RED}❌ Invalid option. Please try again.${RESET}" ;;
        esac
    done
}

# 🚀 Start the script
install_rsync
main_menu
