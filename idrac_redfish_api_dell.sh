#!/bin/bash

# Prompt for iDRAC IP
read -p "Enter iDRAC IP: " IDRAC_IP

# Prompt for username
read -p "Enter username: " USER

# Prompt for password (hidden input)
read -s -p "Enter password: " PASS

echo "======= Collecting Disk Details ========================================================================="

echo "Dell Server Name `host $IDRAC_IP | cut -d" " -f5`"

#IDRAC_IP="IP"
#USER="root"
#PASS="calvin"

#  Enumerate all storage controllers
curl -ksu $USER:$PASS "https://$IDRAC_IP/redfish/v1/Systems/System.Embedded.1/Storage" \
| jq -r '.Members[]."@odata.id"' \
| while read controller; do


    # 1. Get all drive paths under this controller
    drive_paths=$(curl -ksu $USER:$PASS "https://$IDRAC_IP$controller" | jq -r '.. | ."@odata.id"? | select(. != null and contains("/Drives/"))')

    # 2. Skip controller if no drives found
    if [ -n "$drive_paths" ]; then
       echo "=== Controller: $controller ==="

    # 3. Iterate through each drive
        echo "$drive_paths" | while read drive; do
            echo ">>> Drive: $drive"
            curl -ksu $USER:$PASS "https://$IDRAC_IP$drive" \
            | jq -r '{ID: .Id, LifeRemainingPercent: .PredictedMediaLifeLeftPercent, SerialNumber: .SerialNumber, Total_Disk_size_bytes: .CapacityBytes}'
            echo
        done
    fi
done
echo "============================================"
