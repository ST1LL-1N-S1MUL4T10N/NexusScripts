#!/bin/bash

# Check if the script is run as root
if [ "$(id -u)" -ne 0 ]; then
    echo "You must run this script as root!"
    exit 1
fi

# Display a thank you message
echo "Thank you for using this script."
echo "Your syslog will be scanned in ..."
for i in 3 2 1; do
    echo "$i..."
    sleep 1

done

# Preparing to scan syslog

sudo yes "Scanning syslog..." >> /var/log/syslog
