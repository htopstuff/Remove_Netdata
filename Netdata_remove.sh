# Script is to remove Netdata after installing Wordops stack #

#!/bin/bash

# Function to print messages
print_message() {
    echo "--------------------------------------------------"
    echo "$1"
    echo "--------------------------------------------------"
}

# Stop the Netdata service
print_message "Stopping Netdata service"
sudo systemctl stop netdata

# Disable the Netdata service
print_message "Disabling Netdata service"
sudo systemctl disable netdata

# Uninstall Netdata
print_message "Uninstalling Netdata"
sudo apt-get remove --purge -y netdata

# Remove residual configuration files
print_message "Removing residual configuration files"
sudo apt-get autoremove --purge -y netdata

# Remove Netdata directories and files
print_message "Removing Netdata directories and files"
sudo rm -rf /etc/netdata /var/lib/netdata /usr/lib/netdata /var/cache/netdata /var/log/netdata /usr/share/netdata

# Remove Netdata user and group
print_message "Removing Netdata user and group"
sudo deluser --remove-home netdata
sudo delgroup netdata

# Clean up systemd service
print_message "Cleaning up systemd service"
sudo systemctl daemon-reload
sudo systemctl reset-failed

# Check for any remaining Netdata processes and kill them
print_message "Checking for remaining Netdata processes"
remaining_processes=$(ps aux | grep netdata | grep -v grep)

if [ -n "$remaining_processes" ]; then
    print_message "Killing remaining Netdata processes"
    sudo killall netdata
else
    print_message "No remaining Netdata processes found"
fi

print_message "Netdata uninstallation complete"
