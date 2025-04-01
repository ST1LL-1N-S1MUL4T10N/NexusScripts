#!/bin/bash
# Interactive Network Configurator
# Lists available network interfaces and allows interactive configuration
# Requires root privileges.

if [[ $EUID -ne 0 ]]; then
  echo "Please run as root."
  exit 1
fi

echo "Available network interfaces:"
ip -o link show | awk -F': ' '{print $2}'

read -p "Enter the interface name to configure: " iface
read -p "Enter new IP address (e.g., 192.168.1.10): " ipaddr
read -p "Enter netmask (e.g., 24 for /24): " netmask
read -p "Enter gateway (e.g., 192.168.1.1): " gateway

echo "Configuring $iface with IP $ipaddr/$netmask and gateway $gateway..."
ip addr flush dev "$iface"
ip addr add "$ipaddr"/"$netmask" dev "$iface"
ip link set "$iface" up
ip route add default via "$gateway" dev "$iface"

echo "Configuration applied. Use 'ip addr' to verify."
