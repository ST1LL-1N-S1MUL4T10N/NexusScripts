#!/bin/bash
spinner=('/' '-' '\' '|')
i=0
while true; do
    echo -ne "Still in simulation... ${spinner[i]} \r"
    i=$(( (i+1) % 4 ))
    sleep 0.2
done
