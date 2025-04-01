#!/bin/bash
# 📊 Log File Analyzer - Interactive and User-Friendly Log Analysis Tool

# 🎨 Define Colors for Output
GREEN="\e[32m"
YELLOW="\e[33m"
RED="\e[31m"
BLUE="\e[34m"
CYAN="\e[36m"
RESET="\e[0m"

# 📂 Function to browse and select a log file
select_log_file() {
    echo -e "${BLUE}🔍 Searching for log files...${RESET}"
    log_files=($(find . -type f -name "*.log" 2>/dev/null))

    if [[ ${#log_files[@]} -eq 0 ]]; then
        echo -e "${RED}❌ No log files found in the current directory. Please enter a file manually.${RESET}"
        read -p "📂 Enter the full path to the log file: " logfile
    else
        echo -e "${CYAN}📂 Available log files:${RESET}"
        for i in "${!log_files[@]}"; do
            echo -e "${YELLOW}$((i+1))) ${log_files[$i]}${RESET}"
        done

        read -p "🔢 Select a log file by number (or enter a custom path): " choice
        if [[ "$choice" =~ ^[0-9]+$ ]] && (( choice >= 1 && choice <= ${#log_files[@]} )); then
            logfile="${log_files[$((choice-1))]}"
        else
            logfile="$choice"
        fi
    fi

    # Validate file existence
    if [[ ! -f "$logfile" ]]; then
        echo -e "${RED}❌ Error: File not found. Please try again.${RESET}"
        select_log_file
    fi
}

# 🏆 Function to analyze the log file
analyze_log_file() {
    echo -e "${GREEN}📊 Analyzing log file: ${BLUE}$logfile${RESET}"
    
    # Count log levels
    error_count=$(grep -i "ERROR" "$logfile" | wc -l)
    warn_count=$(grep -i "WARN" "$logfile" | wc -l)
    info_count=$(grep -i "INFO" "$logfile" | wc -l)

    # Display formatted results
    echo -e "${CYAN}══════════════════════════════════════${RESET}"
    printf "${BLUE}📋 Log Analysis Summary:${RESET}\n"
    printf "  ${RED}ERROR: %s${RESET}\n" "$error_count"
    printf "  ${YELLOW}WARN:  %s${RESET}\n" "$warn_count"
    printf "  ${GREEN}INFO:  %s${RESET}\n" "$info_count"
    echo -e "${CYAN}══════════════════════════════════════${RESET}"

    # Offer to display errors if any are found
    if (( error_count > 0 )); then
        read -p "⚠️  Do you want to display the last 5 ERROR messages? (y/n): " show_errors
        if [[ "$show_errors" =~ ^[Yy]$ ]]; then
            echo -e "${RED}🛑 Last 5 ERROR messages:${RESET}"
            grep -i "ERROR" "$logfile" | tail -n 5
        fi
    fi
}

# 🏁 Main script execution
echo -e "${GREEN}=== 📊 Log File Analyzer ===${RESET}"

# 📂 Select a log file
select_log_file

# 🔍 Analyze the log file
analyze_log_file
