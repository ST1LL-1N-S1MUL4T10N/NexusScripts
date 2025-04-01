#!/bin/bash

# Check if the script is run as root
if [ "$(id -u)" -ne 0 ]; then
    echo "You must run this script as root!"
    exit 1
fi

# Display a thank you message
echo "Thank you for using this script."
echo "You will take back full control of your DNS in ... !"
for i in 3 2 1; do
    echo "$i..."
    sleep 1
done

# Check if /etc/resolv.conf is a symbolic link (often the case with systemd or resolvconf)
if [ -L /etc/resolv.conf ]; then
    echo "/etc/resolv.conf is a symbolic link, checking if it is managed by systemd or resolvconf"
    
    # If it's managed by systemd, make DNS changes persistent using systemd's network settings
    if systemctl is-active systemd-resolved >/dev/null 2>&1; then
        echo "Systemd-resolved is active. Setting DNS to 127.0.0.1..."
        # Ensure systemd-resolved is configured to use 127.0.0.1 as DNS
        echo "127.0.0.1" > /etc/systemd/resolved.conf.d/dns.conf
        systemctl restart systemd-resolved
        echo "DNS change persisted using systemd-resolved."
    else
        echo "Systemd-resolved is not active, cleaning up /etc/resolv.conf..."
        # If systemd-resolved is not active, clear out the resolv.conf file
        echo -n > /etc/resolv.conf
        echo "nameserver 127.0.0.1" > /etc/resolv.conf
        echo "DNS change persisted in /etc/resolv.conf."
    fi
else
    # If it's not a symlink (not using resolvconf/systemd), modify resolv.conf directly
    echo "No symlink found, modifying /etc/resolv.conf directly."
    echo -n > /etc/resolv.conf
    echo "nameserver 127.0.0.1" > /etc/resolv.conf
    echo "DNS change persisted in /etc/resolv.conf."
fi

# Verify DNS is now 127.0.0.1
echo "Current DNS:"
cat /etc/resolv.conf
