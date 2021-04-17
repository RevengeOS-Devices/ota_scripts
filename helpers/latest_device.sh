#!/bin/bash
# Grab latest device from official_devices repo

git clone https://github.com/RevengeOS-Devices/official_devices official_devices

cd official_devices
git diff-tree --no-commit-id --name-only -r HEAD | sed 's|/.*||' > temp
DEVICE=$(cat temp)
for i in $(cat temp); do
  if [ "$i" == "maintainers.json" ]; then
    DEVICE=maintainers.json
    echo $DEVICE
  fi
done
cd ..
rm -rf official_devices
echo $DEVICE
