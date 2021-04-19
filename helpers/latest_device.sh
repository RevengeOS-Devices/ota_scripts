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
for i in $(cat temp); do
  if [ "$i" == "maintainers.json" ]; then
    DEVICE="maintainers.json"
    echo $DEVICE
    export DEVICE="maintainers.json"
    cleanup
    exit
  fi
done
sed 's|/.*||' -i temp
DEVICE=$(cat temp)
cleanup
echo $DEVICE
export DEVICE
