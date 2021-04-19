#!/bin/bash
# Grab latest device from official_devices repo

cleanup() {
  cd ..
  rm -rf official_devices
}

git clone https://github.com/RevengeOS-Devices/official_devices official_devices

cd official_devices
LIST=$(git diff-tree --no-commit-id --name-only -r HEAD)
echo $LIST > temp
sed 's|/.*||' -i temp
DEVICE=$(cat temp)
for i in $(cat temp); do
  if [ "$i" == "maintainers.json" ]; then
    DEVICE=maintainers.json
    echo $DEVICE
    export $DEVICE
    cleanup
    exit
  fi
done
cleanup
echo $DEVICE
export DEVICE
