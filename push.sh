#!/bin/bash

DEVICENAME=$(python3 ota_scripts/helpers/parse_info.py device_name)
URL=$(python3 ota_scripts/helpers/parse_info.py url)
FILENAME=$(python3 ota_scripts/helpers/parse_info.py filename)
DONATE_URL=$(python3 ota_scripts/helpers/parse_info.py donate_url)
UNIX_DATETIME=$(python3 ota_scripts/helpers/parse_info.py datetime)
ROSVERSION=$(python3 ota_scripts/helpers/parse_info.py version)
TELEGRAM_USERNAME=$(python3 ota_scripts/helpers/parse_info.py tgusername)

SOURCELOG=$(cat changelog.txt)
DEVICELOG=$(cat ${DEVICE}/changelog.txt)

DATETIME=$(date -d @${UNIX_DATETIME})

tg_imagecaptioncast "New RevengeOS update available!" \
	"Device: ${DEVICENAME} (<code>${DEVICE}</code>)" \
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
	"Maintainer: https://t.me/${TELEGRAM_USERNAME}" \
	"Donate: ${DONATE_URL}"

tg_groupcast "OTA announcement pushed for ${DEVICENAME} (${DEVICE}) in ROS News channel!" \
