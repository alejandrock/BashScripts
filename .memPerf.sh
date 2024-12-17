#!/bin/bash

# Get the total memory in GB
total_mem=$(free -g | awk '/Mem:/ {print $2}')

# Get the used memory in GB
used_mem=$(free -g | awk '/Mem:/ {print $3}')

# Calculate the free memory in GB
free_mem=$((total_mem - used_mem))

# Print the results
echo "Total memory: $total_mem GB"
echo "Used memory: $used_mem GB"
echo "Free memory: $free_mem GB"


