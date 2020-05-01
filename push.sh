#!/bin/bash

DEVICENAME=$(python3 ota_scripts/helpers/parse_info.py device_name)
URL=$(python3 ota_scripts/helpers/parse_info.py url)
FILENAME=$(python3 ota_scripts/helpers/parse_info.py filename)
DONATE_URL=$(python3 ota_scripts/helpers/parse_info.py donate_url)
UNIX_DATETIME=$(python3 ota_scripts/helpers/parse_info.py datetime)
ROSVERSION=$(python3 ota_scripts/helpers/parse_info.py version)
TELEGRAM_USERNAME=$(python3 ota_scripts/helpers/parse_info.py tgusername)

DATETIME=$(date -d @${UNIX_DATETIME})

tg_imagecaptioncast "New RevengeOS update available!" \
	"Device: ${DEVICE_NAME} <code>${DEVICE}</code>" \
	" " \
	"RevengeOS Version: ${ROSVERSION}" \
	"Build date: ${DATETIME}" \
	" " \
	"Download link: <a href='${URL}'>${FILENAME}</a>" \
	"Maintainer: https://t.me/${TELEGRAM_USERNAME}"
