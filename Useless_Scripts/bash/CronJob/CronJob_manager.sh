#!/bin/bash
# 🕒 Ultimate Cron Job Manager - Interactive & User-Friendly Task Scheduler

# 🎨 Define Colors for Output
GREEN="\e[32m"
YELLOW="\e[33m"
RED="\e[31m"
BLUE="\e[34m"
CYAN="\e[36m"
RESET="\e[0m"

# 📝 Function to show current cron jobs
show_cron_jobs() {
    echo -e "${BLUE}📋 Current Cron Jobs:${RESET}"
    crontab -l 2>/dev/null || echo -e "${YELLOW}⚠️ No cron jobs found.${RESET}"
}

# 🕒 Function to help users create cron schedule
cron_helper() {
    echo -e "${CYAN}🕒 Cron Schedule Guide:${RESET}"
    echo -e "${YELLOW} ┌───────── Minute (0 - 59)
 │ ┌───────── Hour (0 - 23)
 │ │ ┌───────── Day of Month (1 - 31)
 │ │ │ ┌───────── Month (1 - 12)
 │ │ │ │ ┌───────── Day of Week (0 - 6) (Sunday = 0 or 7)
 │ │ │ │ │
 * * * * * command-to-run ${RESET}"
    echo -e "${GREEN}Examples:${RESET}"
    echo -e "  ${YELLOW}Every day at midnight:${RESET} 0 0 * * * /path/to/script.sh"
    echo -e "  ${YELLOW}Every Monday at 8 AM:${RESET} 0 8 * * 1 /path/to/script.sh"
    echo -e "  ${YELLOW}Every 5 minutes:${RESET} */5 * * * * /path/to/script.sh"
    echo ""
}

# ➕ Function to add a new cron job
add_cron_job() {
    read -p "📂 Enter the full path to the script: " script_path
    if [[ ! -f "$script_path" ]]; then
        echo -e "${RED}❌ Script not found. Please enter a valid path.${RESET}"
        return
    fi
    if [[ ! -x "$script_path" ]]; then
        echo -e "${YELLOW}⚠️  Script is not executable. Fixing permissions...${RESET}"
        chmod +x "$script_path" && echo -e "${GREEN}✅ Script is now executable.${RESET}"
    fi

    cron_helper
    read -p "🕒 Enter cron schedule (e.g., \"0 5 * * *\"): " cron_schedule

    (crontab -l 2>/dev/null; echo "$cron_schedule $script_path") | crontab -
    echo -e "${GREEN}✅ Cron job added successfully!${RESET}"
}

# ❌ Function to delete a specific cron job
delete_cron_job() {
    echo -e "${CYAN}📋 Your current cron jobs:${RESET}"
    crontab -l > cron_backup.txt
    nl -ba cron_backup.txt
    read -p "❌ Enter the job number to delete (or press Enter to cancel): " job_num
    if [[ -n "$job_num" ]]; then
        sed -i "${job_num}d" cron_backup.txt
        crontab cron_backup.txt && echo -e "${GREEN}✅ Cron job deleted successfully!${RESET}"
    else
        echo -e "${YELLOW}⚠️ No changes made.${RESET}"
    fi
    rm -f cron_backup.txt
}

# 🔄 Function to reset all cron jobs
reset_cron_jobs() {
    read -p "⚠️ Are you sure you want to remove all cron jobs? (y/n): " confirm
    if [[ "$confirm" =~ ^[Yy]$ ]]; then
        crontab -r && echo -e "${GREEN}✅ All cron jobs removed.${RESET}"
    else
        echo -e "${YELLOW}⚠️ Reset cancelled.${RESET}"
    fi
}

# 📌 Main Menu
main_menu() {
    while true; do
        echo -e "${GREEN}\n=== 🕒 Cron Job Manager ===${RESET}"
        echo -e "${BLUE}1) View Cron Jobs${RESET}"
        echo -e "${BLUE}2) Add a New Cron Job${RESET}"
        echo -e "${BLUE}3) Delete a Cron Job${RESET}"
        echo -e "${BLUE}4) Reset All Cron Jobs${RESET}"
        echo -e "${BLUE}5) Exit${RESET}"

        read -p "🔹 Select an option: " option
        case "$option" in
            1) show_cron_jobs ;;
            2) add_cron_job ;;
            3) delete_cron_job ;;
            4) reset_cron_jobs ;;
            5) echo -e "${GREEN}🚀 Exiting...${RESET}"; exit 0 ;;
            *) echo -e "${RED}❌ Invalid option. Please try again.${RESET}" ;;
        esac
    done
}

# 🚀 Start the script
main_menu
