#!/bin/bash

########
# Author: Bhagwati Bashyal
# Date: 15-02-2025
#
# Version: v1
#
# Server Information Report
#
# This script provides a comprehensive overview of server resources and usage
########

echo "======= Server Information Report ======="
echo "Date: $(date)"
echo "----------------------------------------"


# OS Version
echo "OS Version:"
cat /etc/os-release | grep PRETTY_NAME | cut -d'"' -f2
echo "----------------------------------------"
# cat /etc/os-release: Displays the content of the os-release file.
# grep PRETTY_NAME: Filters for the line containing "PRETTY_NAME" which contains the OS name and version.
# cut -d'"' -f2: Extracts the text between the second set of quotation marks.


# Uptime
echo "System Uptime:"
uptime -p
echo "----------------------------------------"
# uptime -p: Shows how long the system has been running in a pretty, human-readable format.



# Get CPU information
echo "CPU Usage:"
CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | awk '{print 100 - $8 "%"}')
echo $CPU_USAGE
echo "----------------------------------------"



# Get Memory Usage information
echo "Memory Usage:"
MEM_INFO=$(free -m)
TOTAL_MEM=$(echo "$MEM_INFO" | awk 'NR==2{print $2}')
USED_MEM=$(echo "$MEM_INFO" | awk 'NR==2{print $3}')
FREE_MEM=$(echo "$MEM_INFO" | awk 'NR==2{print $4}')
MEM_PERCENTAGE=$(( 100 * USED_MEM / TOTAL_MEM ))
echo -e "Total Memory Usage: ${USED_MEM}MB / ${TOTAL_MEM}MB (${MEM_PERCENTAGE})"
echo "----------------------------------------"


# Get Disk Usage information
echo "Disk Usage:"
DISK_INFO=$(df -h)
TOTAL_DISK=$(echo "$DISK_INFO" | awk '$NF=="/"{print $2}')
USED_DISK=$(echo "$DISK_INFO" | awk '$NF=="/"{print $3}')
FREE_DISK=$(echo "$DISK_INFO" | awk '$NF=="/"{print $4}')
DISK_PERCENTAGE=$(echo "$DISK_INFO" | awk '$NF=="/"{print $5}')
echo -e "${YELLOW}Total Disk Usage: ${USED_DISK} / ${TOTAL_DISK} (${DISK_PERCENTAGE})"



# Top 5 CPU-consuming processes
echo "Top 5 CPU-consuming processes:"
ps aux --sort=-%cpu | head -n 6
echo "----------------------------------------"
# ps aux: Lists all processes.
# --sort=-%cpu: Sorts the output by CPU usage (descending order).
# head -n 6: Shows only the first 6 lines (header + top 5 processes).



# Top 5 Memory-consuming processes
echo "Top 5 Memory-consuming processes:"
ps aux --sort=-%mem | head -n 6
echo "----------------------------------------"
# Similar to the previous command, but sorts by memory usage (-%mem) instead of CPU.



# Logged in users
echo "Currently logged in users:"
who
echo "----------------------------------------"
#who: Shows who is logged on.


# Failed login attempts
echo "Failed login attempts:"
if [ -f "/var/log/auth.log" ]; then
    grep "Failed password" /var/log/auth.log | wc -l
else
    echo "Auth log not accessible or doesn't exist."
fi
echo "----------------------------------------"
# grep "Failed password" /var/log/auth.log: Searches for lines containing "Failed password" in the auth log.
# wc -l: Counts the number of lines, giving the number of failed attempts.

echo "======= End of Server Information Report ======="