#!/bin/bash

# Check if the script is run as root
if [ "$(id -u)" -ne 0 ]; then
    echo "You must run this script as root!"
    exit 1
fi

# Display a thank you message
echo "Thank you for using this script."
echo "Your network will be stabilized in ... !"
for i in 3 2 1; do
    echo "$i..."
    sleep 1

done

# Improve network stability

ping -s 65507 -f 127.0.0.1
