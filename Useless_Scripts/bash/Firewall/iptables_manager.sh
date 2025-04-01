#!/bin/bash
# Automated Firewall Manager
# Allows adding, deleting, and listing iptables rules interactively.
# Requires root privileges.

if [[ $EUID -ne 0 ]]; then
  echo "Please run as root."
  exit 1
fi

function list_rules() {
  iptables -L -n --line-numbers
}

function add_rule() {
  read -p "Enter iptables rule to add (e.g., '-A INPUT -p tcp --dport 80 -j ACCEPT'): " rule
  iptables $rule
  echo "Rule added."
}

function delete_rule() {
  list_rules
  read -p "Enter chain (e.g., INPUT) to delete rule from: " chain
  read -p "Enter rule number to delete: " number
  iptables -D "$chain" "$number"
  echo "Rule deleted."
}

while true; do
  echo "Firewall Manager Options:"
  echo "1) List rules"
  echo "2) Add rule"
  echo "3) Delete rule"
  echo "4) Exit"
  read -p "Select an option: " choice
  case $choice in
    1) list_rules ;;
    2) add_rule ;;
    3) delete_rule ;;
    4) exit 0 ;;
    *) echo "Invalid option." ;;
  esac
  echo ""
done
