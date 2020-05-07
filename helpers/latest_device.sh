#!/bin/bash
# Grab latest device from official_devices repo

git clone https://github.com/RevengeOS-Devices/official_devices --depth=1 official_devices

cd official_devices
MESSAGE=$(git log -1 HEAD --pretty=format:%s)

for word in $MESSAGE
do
    a+=("$word")
done

DEVICE=${a[1]}
cd ..
rm -rf official_devices
echo $DEVICE
export DEVICE