#!/bin/bash
# Grab latest device from official_devices repo

git clone https://github.com/RevengeOS-Devices/official_devices official_devices

cd official_devices
LIST=$(git diff-tree --no-commit-id --name-only -r HEAD)
echo $LIST > temp
sed 's|/.*||' -i temp
DEVICE=$(cat temp)
cd ..
rm -rf official_devices
echo $DEVICE
export DEVICE
