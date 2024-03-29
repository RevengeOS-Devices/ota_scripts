#!/bin/bash
# Giovix92 was here, 20/03/2021 owo

source $(pwd)/helpers/push_helpers.sh

# Export TARGET_DEVICE from last updated device inside official_devices
TARGET_DEVICE=$(bash $(pwd)/helpers/latest_device.sh)

# Abort if TARGET_DEVICE equals to changelog.txt or maintainers.json
if [ "$TARGET_DEVICE" == "maintainers.json" ] || [ "$TARGET_DEVICE" == "changelog.txt" ]; then
	tg_groupcast "Only maintainers.json or changelog.txt has been updated. Ignoring."
	exit
fi

# Just a lil safety check
FLAG=$(cat file)
if [ "$FLAG" == "0" ]; then
	tg_groupcast "Not pushing, only core files updated."
    exit
elif [ "$FLAG" == "1" ]; then
	echo "Pushing right now, won't sleep!"
else
    echo "Sleepin'..."
	sleep 300
	echo "Sleepin'..."
	sleep 300
fi

# Fetch device.json from our github repo
wget https://raw.githubusercontent.com/RevengeOS-Devices/official_devices/master/$TARGET_DEVICE/device.json
URL="https://download.revengeos.com/download/${TARGET_DEVICE}"
FILENAME=$(jq ".filename" device.json | sed 's/"//g')
DONATE_URL=$(jq ".donate_url" device.json | sed 's/"//g')
UNIX_DATETIME=$(jq ".datetime" device.json | sed 's/"//g')
ROSVERSION=$(jq ".version" device.json | sed 's/"//g')
MD5HASH=$(jq ".filehash" device.json | sed 's/"//g')
CLEAN_FLASH=$(jq ".clean_flash" device.json | sed 's/"//g')

# Fetch maintainer's info by looking for target_device inside maintainers.json
# Also fetch it dynamically from our github repo
wget https://raw.githubusercontent.com/RevengeOS-Devices/official_devices/master/maintainers.json
BRANDNAME=$(jq ".$TARGET_DEVICE.brand" maintainers.json | sed 's/"//g')
DEVICENAME=$(jq ".$TARGET_DEVICE.name" maintainers.json | sed 's/"//g')
MAINTAINER=$(jq ".$TARGET_DEVICE.maintainer" maintainers.json | sed 's/"//g')
TELEGRAM_USERNAME=$(jq ".$TARGET_DEVICE.telegram" maintainers.json | sed 's/"//g')
XDA_THREAD=$(jq ".$TARGET_DEVICE.xda_thread" maintainers.json | sed 's/"//g')

# Set DONATE_URL with a default value if empty
if [ "$DONATE_URL" == "" ]; then
	DONATE_URL=$(echo "https://paypal.me/lucchetto")
fi

# Check if CLEAN_FLASH is empty and/or set with yes/no.
if [ "$CLEAN_FLASH" == "" ] || [ "$CLEAN_FLASH" == "no" ]; then
	echo "Dirty flash possible!" > notes_$TARGET_DEVICE.txt
elif [ "$CLEAN_FLASH" == "yes" ]; then
	echo "Clean flash highly advised!" > notes_$TARGET_DEVICE.txt
fi

# Fetch device's changelog too
wget https://raw.githubusercontent.com/RevengeOS-Devices/official_devices/master/$TARGET_DEVICE/changelog.txt

# Rename it to changelog_$TARGET_DEVICE.txt in order to avoid issues with source changelog
mv changelog.txt changelog_$TARGET_DEVICE.txt

# Fetch device's notes, if any.
wget https://raw.githubusercontent.com/RevengeOS-Devices/official_devices/master/$TARGET_DEVICE/notes.txt && cat notes.txt >> notes_$TARGET_DEVICE.txt

# Fetch source changelog
wget https://raw.githubusercontent.com/RevengeOS-Devices/official_devices/master/changelog.txt

# Make it look pretty
sed -i -e 's/^/- /g' changelog.txt
sed -i -e 's/^/- /g' changelog_$TARGET_DEVICE.txt
sed -i -e 's/^/- /g' notes_$TARGET_DEVICE.txt

SOURCELOG=$(cat changelog.txt)
DEVICELOG=$(cat changelog_$TARGET_DEVICE.txt)
NOTES=$(cat notes_$TARGET_DEVICE.txt)

DATETIME=$(date -d @${UNIX_DATETIME})

tg_channelcast "<b>New build available for ${TARGET_DEVICE}</b>" \
 "Device: ${BRANDNAME} ${DEVICENAME}" \
 "Version and date: ${ROSVERSION} ${DATETIME}" \
 " " \
 "Changelog:" \
 "${DEVICELOG}" \
 " " \
 "Notes:" \
 "${NOTES}" \
 " " \
 "Download: <a href='${URL}'>${FILENAME}</a>" \
 "MD5 checksum: (<code>${MD5HASH}</code>)" \
 "XDA thread: <a href='${XDA_THREAD}'>Tap here</a>" \
 "Maintainer: ${MAINTAINER} (${TELEGRAM_USERNAME})" \
 "Read: <a href='https://blog.revengeos.com/we-need-developers/'>Tap here</a>" \
 "Wanna donate? Do it <a href='${DONATE_URL}'>here</a>!"

tg_groupcast "Pushed release announcement for ${DEVICENAME} (${TARGET_DEVICE}) in RevengeOS News."
