#!/bin/bash
# Real Time Network Monitor
# Displays active network connections and bandwidth usage interactively.

while true; do
  clear
  echo "Active network connections:"
  netstat -tunapl | head -n 15
  echo ""
  echo "Bandwidth usage (Press Ctrl+C to exit):"
  if command -v ifstat >/dev/null 2>&1; then
    ifstat -t 1 1
  else
    echo "ifstat not installed. Install with: sudo apt-get install ifstat"
  fi
  sleep 2
done
