#!/bin/bash


# Retrieve battery information and filter relevant details
battery_info=$(upower -i $(upower -e | grep BAT) | grep -E "state|percentage|time to empty|time to full|energy-rate|capacity|voltage")

# Print relevant battery details
echo "$battery_info" | awk '{print $1, $2}'

# Calculate and display estimated time until power off
percentage=$(echo "$battery_info" | awk '/percentage/{print $2}')
discharging_rate=$(echo "$battery_info" | awk '/energy-rate/{print $2}')
time_to_empty=$(echo "$battery_info" | awk '/time to empty/{print $4}')
if [[ $discharging_rate != "unknown" && $percentage != "unknown" && $(bc <<< "$discharging_rate > 0") -eq 1 ]]; then
    hours=$(echo "scale=2; $percentage / $discharging_rate" | bc)
    echo "Time to discharge and power off: approximately $hours hours"
elif [[ $percentage == "unknown" ]]; then
    echo "Unable to determine battery percentage."
else
    echo "Battery is not discharging or discharging rate is unknown."
fi



