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

# Function to represent "Ping"
function a {
  while true; do
    echo "Ping?"
    b # Calling the b function
    sleep 1 # Optional delay to avoid overloading the CPU
  done
}

# Function to represent "Pong"
function b {
  while true; do
    echo "Pong!"
    a # Calling the a function
    sleep 1 # Optional delay to prevent CPU overload
  done
}

# Start the infinite loop by calling the first function
a
