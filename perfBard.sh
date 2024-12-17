#!/bin/bash

# Get system memory usage
MEM_FREE=$(cat /proc/meminfo | awk '/MemFree/ {print $2}')
MEM_TOTAL=$(cat /proc/meminfo | awk '/MemTotal/ {print $2}')
MEM_PERCENT_USED=$((MEM_FREE * 100 / MEM_TOTAL))

# Get system disk usage
DISK_USED=$(df -h / | awk '{print $3}')
DISK_TOTAL=$(df -h / | awk '{print $2}')
DISK_PERCENT_USED=$((DISK_USED * 100 / DISK_TOTAL))

# Get system CPU usage
CPU_USAGE=$(sar -u 1 1 | tail -1 | awk '{print $3}')

# Get system GPU usage (if available)
GPU_USAGE=$(nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader | awk '{print $1}')

# Get system internet connection speed
SPEED_TEST=$(speedtest-cli --simple)

# Get Bogota time
BOGOTA_TIME=$(date -u +"%Y-%m-%d %H:%M")

# Print system monitoring results
echo "System Memory Usage: ${MEM_FREE} MB / ${MEM_TOTAL} MB (${MEM_PERCENT_USED}%)"
echo "System Disk Usage: ${DISK_USED} GB / ${DISK_TOTAL} GB (${DISK_PERCENT_USED}%)"
echo "System CPU Usage: ${CPU_USAGE}%"
if [[ -n "${GPU_USAGE}" ]]; then
  echo "System GPU Usage: ${GPU_USAGE}%"
fi
echo "System Internet Connection Speed: ${SPEED_TEST}"
echo "Bogota Time: ${BOGOTA_TIME}"

# Sleep for 2 minutes
sleep 120
  
