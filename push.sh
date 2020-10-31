#!/bin/bash
# Giovix92 was here, 31/10/2020

source $(pwd)/helpers/push_helpers.sh

# Export TARGET_DEVICE from last updated device inside official_devices
TARGET_DEVICE=$(bash $(pwd)/helpers/latest_device.sh)

# Fetch device.json from our github repo
wget https://raw.githubusercontent.com/RevengeOS-Devices/official_devices/master/$TARGET_DEVICE/device.json
URL=$(jq ".website_url" device.json)
FILENAME=$(jq ".filename" device.json)
DONATE_URL=$(jq ".donate_url" device.json)
UNIX_DATETIME=$(jq ".datetime" device.json)
ROSVERSION=$(jq ".version" device.json)

# Fetch maintainer's info by looking for target_device inside maintainers.json
# Also fetch it dynamically from our github repo
wget https://raw.githubusercontent.com/RevengeOS-Devices/official_devices/master/maintainers.json
DEVICENAME=$(jq ".$TARGET_DEVICE.name" maintainers.json)
MAINTAINER=$(jq ".$TARGET_DEVICE.maintainer" maintainers.json)
TELEGRAM_USERNAME=$(jq ".$TARGET_DEVICE.telegram" maintainers.json)
XDA_THREAD=$(jq ".$TARGET_DEVICE.xda_thread" maintainers.json)

# Fetch device's changelog too
wget https://raw.githubusercontent.com/RevengeOS-Devices/official_devices/master/$TARGET_DEVICE/changelog.txt

# Rename it to changelog_$TARGET_DEVICE.txt in order to avoid issues with source changelog
mv changelog.txt changelog_$TARGET_DEVICE.txt

# Fetch source changelog
wget https://raw.githubusercontent.com/RevengeOS-Devices/official_devices/master/changelog.txt

# Make it look pretty
sed -i -e 's/^/- /g' changelog.txt
sed -i -e 's/^/- /g' changelog_$TARGET_DEVICE.txt

SOURCELOG=$(cat changelog.txt)
DEVICELOG=$(cat changelog_$TARGET_DEVICE.txt)

DATETIME=$(date -d @${UNIX_DATETIME})

tg_groupcast "New RevengeOS update available!" "Device: ${DEVICENAME} (<code>${DEVICE}</code>)" "XDA thread: ${XDA_THREAD}" " " "RevengeOS Version: ${ROSVERSION}" "Build date: ${DATETIME}" " " "Device changelog:" "${DEVICELOG}" " " "Source changelog:" "${SOURCELOG}" " " "Download link: <a href='${URL}'>${FILENAME}</a>" "Maintainer: ${MAINTAINER} (@${TELEGRAM_USERNAME})" "Donate: ${DONATE_URL}"

tg_groupcast "OTA announcement pushed for ${DEVICENAME} (${DEVICE}) in ROS News channel!"
