#!/bin/bash

echo "Starting Full System Summary..."
echo "================================"

# Function to monitor CPU usage per core and overall
cpu_usage() {
    echo -e "\n### CPU Usage ###"
    # Overall CPU usage
    echo "Overall CPU Usage:"
    top -bn1 | grep "Cpu(s)" | awk '{print "User: "$2"%", "System: "$4"%", "Idle: "$8"%"}'
    
    # Per-core usage
    echo -e "\nPer-Core CPU Usage:"
    mpstat -P ALL 1 1 | awk '/Average/ && $2 ~ /[0-9]+/ {print "Core " $2 ": " 100 - $12"%"}'
}

# Function to monitor memory and swap usage
memory_usage() {
    echo -e "\n### Memory Usage ###"
    free -m | awk 'NR==2{printf "Total: %s MiB, Used: %s MiB, Free: %s MiB, Buffers/Cache: %s MiB\n", $2, $3, $4, $6+$7}'
    free -m | awk 'NR==3{printf "Swap Total: %s MiB, Used: %s MiB, Free: %s MiB\n", $2, $3, $4}'
}

# Function to list top memory-consuming processes
top_memory_processes() {
    echo -e "\n### Top Memory-Consuming Processes ###"
    echo "PID   %MEM  USER    COMMAND"
    ps aux --sort=-%mem | awk 'NR<=5 {printf "%-5s %-5s %-8s %s\n", $2, $4, $1, $11}'
}

# Function to show disk usage
disk_usage() {
    echo -e "\n### Disk Usage ###"
    df -h --total | awk '{if (NR==1 || $6 == "/") print}'
}

# Function to show network usage
network_usage() {
    echo -e "\n### Network Usage ###"
    # Show active network interfaces with IP addresses
    ip -brief addr show | grep -v "lo" | awk '{print "Interface: "$1, "| IP Address: "$3}'
    # Show received and transmitted bytes on each interface
    echo -e "\nData Transferred (Bytes):"
    cat /proc/net/dev | awk 'NR>2 {printf "%s - RX: %s, TX: %s\n", $1, $2, $10}'
}

# Function to show system uptime
system_uptime() {
    echo -e "\n### System Uptime ###"
    uptime -p | sed 's/up //'
    echo "Current Load Average:"
    uptime | awk -F'load average:' '{print $2}'
}

# Function to show CPU and system details
system_info() {
    echo -e "\n### System Information ###"
    lscpu | grep -E 'Model name|Socket|Thread|CPU MHz'
    echo -e "\nMemory Information:"
    free -h | awk 'NR==2{printf "Total Memory: %s, Used: %s, Free: %s\n", $2, $3, $4}'
}

# Function to show temperature readings if sensors are available
temperature_readings() {
    if command -v sensors &> /dev/null; then
        echo -e "\n### Temperature Readings ###"
        sensors | grep -E 'Core|temp1' || echo "Temperature sensors not available."
    else
        echo -e "\n### Temperature Readings ###"
        echo "sensors command not found. Install with 'sudo apt install lm-sensors' to view temperatures."
    fi
}

# Run all functions to display a full system summary
cpu_usage
memory_usage
top_memory_processes
disk_usage
network_usage
system_uptime
system_info
temperature_readings

echo -e "\nFull System Summary Complete."
