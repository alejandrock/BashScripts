#!/bin/bash

# Function to check the exit status and exit on failure
check_command_status() {
    if [ $? -ne 0 ]; then
        echo "Command failed with exit status $?."
        exit 1
    fi
}

# Clean packages
echo "Cleaning packages..."
sudo apt-get autoremove -y
sudo apt-get autoclean -y
sudo apt-get clean -y

# Update the system
echo "Updating system..."
sudo apt update
sudo apt dist-upgrade -y

# Upgrade packages
echo "Upgrading packages..."
sudo apt upgrade -y

# Clean up
echo "Cleaning up..."
sudo apt autoremove -y

echo "****System update and cleanup complete.****"
  
