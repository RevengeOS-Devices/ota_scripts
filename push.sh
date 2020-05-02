#!/bin/bash

CHECK=$(git diff --name-only HEAD~1 .)

if [[ $CHECK = "maintainers.json" ]];
then
	echo $CHECK
	echo "Not pushing due to no new update"
	exit 1
fi

URL=$(python3 ota_scripts/helpers/parse_info_device.py url)
FILENAME=$(python3 ota_scripts/helpers/parse_info_device.py filename)
DONATE_URL=$(python3 ota_scripts/helpers/parse_info_device.py donate_url)
UNIX_DATETIME=$(python3 ota_scripts/helpers/parse_info_device.py datetime)
ROSVERSION=$(python3 ota_scripts/helpers/parse_info_device.py version)
DEVICENAME=$(python3 ota_scripts/helpers/parse_info_maintainers.py ${DEVICE} name)
MAINTAINER=$(python3 ota_scripts/helpers/parse_info_maintainers.py ${DEVICE} maintainer)
TELEGRAM_USERNAME=$(python3 ota_scripts/helpers/parse_info_maintainers.py ${DEVICE} telegram)
XDA_THREAD=$(python3 ota_scripts/helpers/parse_info_maintainers.py ${DEVICE} xda_thread)

# Make it look pretty
sed -i -e 's/^/- /g' changelog.txt
sed -i -e 's/^/- /g' ${DEVICE}/changelog.txt

SOURCELOG=$(cat changelog.txt)
DEVICELOG=$(cat ${DEVICE}/changelog.txt)

DATETIME=$(date -d @${UNIX_DATETIME})

tg_imagecaptioncast "New RevengeOS update available!" \
	"Device: ${DEVICENAME} (<code>${DEVICE}</code>)" \
	"XDA thread: ${XDA_THREAD}" \
	" " \
	"RevengeOS Version: ${ROSVERSION}" \
	"Build date: ${DATETIME}" \
	" " \
       	"Device changelog:" \
        "${DEVICELOG}" \
       	" " \
	"Source changelog:" \
	"${SOURCELOG}" \
        " " \
	"Download link: <a href='${URL}'>${FILENAME}</a>" \
	"Maintainer: ${MAINTAINER} (@${TELEGRAM_USERNAME})" \
	"Donate: ${DONATE_URL}"

tg_groupcast "OTA announcement pushed for ${DEVICENAME} (${DEVICE}) in ROS News channel!"
