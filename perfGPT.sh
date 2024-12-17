#!/bin/bash

# Set the system's timezone to Bogotá
export TZ="America/Bogota"

# Function to get RAM and Swap usage
function monitor_memory() {
    echo "Memory and Swap Usage ($(date +'%Y-%m-%d %H:%M:%S')):"
    free -h
}

# Function to check disk space
function monitor_disk_space() {
    echo "Disk Space Usage ($(date +'%Y-%m-%d %H:%M:%S')):"
    df -h
}

# Function to check disk speed
function monitor_disk_speed() {
    echo "Disk Speed ($(date +'%Y-%m-%d %H:%M:%S')):"
    sudo hdparm -t /dev/sda  # Replace /dev/sda with your disk device
}

# Function to monitor CPU usage
function monitor_cpu() {
    echo "CPU Usage ($(date +'%Y-%m-%d %H:%M:%S')):"
    top -b -n 1 | awk '/%Cpu/'
}

# Function to check internet connection speed
function monitor_internet_speed() {
    echo "Internet Connection Speed ($(date +'%Y-%m-%d %H:%M:%S')):"
    speedtest-cli --simple
}

# Main function
function main() {
    clear
    echo "System Monitoring Script"
    echo "-----------------------"
    monitor_memory  
    echo
    monitor_disk_space
    echo
    monitor_disk_speed
    echo
    monitor_cpu
    echo
    monitor_internet_speed
}

# Run the main function directly, without watch
main

