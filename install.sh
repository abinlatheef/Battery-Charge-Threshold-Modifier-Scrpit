#!/bin/bash
path="/etc/systemd/system/battery-charge-threshold.service"
BAT=$(ls /sys/class/power_supply/ | grep BAT)
sudo wget https://raw.githubusercontent.com/abinlatheef/Battery-Charge-Threshold-Modifier/main/battery-charge-threshold.service -P /etc/systemd/system/
sed -i 's/BATTERY_NAME/$BAT/g' $path
echo "Systemd service created"
systemctl enable battery-charge-threshold.service
systemctl start battery-charge-threshold.service

echo "--CHANGE BATTERY CHARGE THRESHOLD--"
current=$(awk 'NR == 10 {print $4}' $path)
echo "Current Threshold = $current"
echo -n "Enter the required Threshold : "
read new
sed -i s/$current/$new/ $path
echo "Threshold modification successful!"
systemctl daemon-reload
systemctl restart battery-charge-threshold.service
