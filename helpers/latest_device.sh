#!/bin/bash
# Grab latest device from official_devices repo

git clone https://github.com/RevengeOS-Devices/official_devices --depth=1 official_devices

DEVICE=$(ls -td official_devices/*/ | head -1)
echo $DEVICE > device
sed -i 's|official_devices/||g' device
sed -i 's|/||g' device
DEVICE=$(cat device)
rm device
rm -rf official_devices
echo $DEVICE
export DEVICE
