#!/bin/bash

# Get the total memory in MB
total_mem_mb=$(awk '/MemTotal:/{print $2}' /proc/meminfo)

# Get the used memory in MB
used_mem_mb=$(awk '/MemFree:/{print $2}' /proc/meminfo)

# Get the memory used by apps in MB
apps_mem_mb=$(ps aux --sort=-rss | awk '{print $6}' | tail -n +2 | awk '{s+=$1} END {print s}')

# Calculate the memory used by the system in MB
sys_mem_mb=$(bc <<< "scale=2;$used_mem_mb-$apps_mem_mb")

# Display the results
echo "Total memory: $total_mem_mb MB"
echo "Used memory: $used_mem_mb MB"
echo "Apps memory usage: $apps_mem_mb MB"
echo "System memory usage: $sys_mem_mb MB"

