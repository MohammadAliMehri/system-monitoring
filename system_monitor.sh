#!/bin/bash
TOKEN="token_bot" # replace bot token here
CHAT_ID="chat_id" # replace user chat id here
# System Update and Upgrade
if sudo apt update &>/dev/null && sudo apt full-upgrade -y &>/dev/null; then
   UPDATE_MESSAGE="System update completed successfully ✅"
else
   UPDATE_MESSAGE="System update failed ❌"
fi

# System Update and Upgrade Completely
if sudo apt-get update &>/dev/null && sudo apt-get upgrade -y &>/dev/null && sudo apt-get dist-upgrade -y &>/dev/null; then
   FULLUP_MESSAGE="Full Update And Upgrade Completed Successfully ✅"
else
   FULLUP_MESSAGE="Full Update And Upgrade Failed ❌"
fi

# Clean APT cache
if sudo apt-get clean &>/dev/null; then 
   CLEAN_MESSAGE="APT cache cleaned successfully ✅"
else
   CLEAN_MESSAGE="Failed to clean APT cache ❌"
fi

# Remove unnecessary packages
if sudo apt autoremove -y &>/dev/null; then
   REMOVE_MESSAGE="Removal of unnecessary packages completed successfully ✅"
else
   REMOVE_MESSAGE="Removal of unnecessary packages failed ❌"
fi
# Show final status    
echo "$UPDATE_MESSAGE"
echo "$FULLUP_MESSAGE"
echo "$CLEAN_MESSAGE"
echo "$REMOVE_MESSAGE"

echo "System maintenance tasks completed. ✅"    
# FUll System Monitoring for 1 minute
if ! command -v vmstat &>/dev/null; then
        echo "Sysstat is not installed. Installing now..."
    sudo apt-get install sysstat -y &>/dev/null
    if command -v vmstat &>/dev/null; then 
        echo "Sysstat packages were installed successfully. ✅"
    else
        echo "Failed to install Sysstat ❌"
    fi
else
        echo "Sysstat is already installed. ✅"
fi
# Save vmstat details
vmstat 5 12 > vmstat_output.txt # 12 reports in 1 minute
   echo "Vmstat results saved to vmstat_output.txt"
# Save iostat details
iostat -x 10 6 > iostat_output.txt # 6 reports in 1 minute
   echo "Iostat results saved to iostat_output.txt"
# Save mpstat details
mpstat -P ALL 5 12 > mpstat_output.txt # 12 reports in 1 minute
   echo "Mpstat results saved to mpstat_output.txt"
# Send Files to TG
FILES=(
    "/root/vmstat_output.txt"
    "/root/mpstat_output.txt"
    "/root/iostat_output.txt"
)
M_MESSAGE="Monitoring Files Successfully Sended to Telegram [vmstat-mpstat-iostat] ✅"

# Show Ram Usage
RAM_USAGE=$(free -h | awk '/^Mem:/ { print $3 "/" $2 }')
# Disk Usage
DISK_USAGE=$(df -h / | grep / | awk '{ print $5 }')
# Show Uptime
UPTIME=$(uptime -p)
UPTIME_MESSAGE="System Uptime: $UPTIME 🌡️"
# Show Date
DATE=$(date +"%Y-%m-%d %H:%M:%S")
MESSAGE="$UPDATE_MESSAGE%0A$FULLUP_MESSAGE%0A$REMOVE_MESSAGE%0A$CLEAN_MESSAGE%0A$UPTIME_MESSAGE%0A$M_MESSAGE%0ARam Usage: $RAM_USAGE%0ADisk Usage: $DISK_USAGE%0ADate: $DATE"
# Check if curl is installed or not
if ! command -v curl &>/dev/null; then
    echo "Curl is not installed. Installing now..."
    sudo apt-get install curl -y &>/dev/null
    if command -v curl &>/dev/null; then
        echo "Curl was installed successfully. ✅"
    else
        echo "Failed to install Curl ❌"
    fi
else
    echo "Curl is already installed. ✅"
fi
# Send a message to Telegram
curl -s -X POST "https://api.telegram.org/bot$TOKEN/sendMessage" -d chat_id=$CHAT_ID -d text="$MESSAGE"&> /dev/null
for FILE_PATH in "${FILES[@]}"
do
    curl -F "chat_id=$CHAT_ID" \
         -F "document=@$FILE_PATH" \
         "https://api.telegram.org/bot$TOKEN/sendDocument"&> /dev/null
done
   echo "All Tasks Successfully Completed ;)"

# 08/15/2024 Thursday
