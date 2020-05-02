#!/bin/bash
# Telegram helpers for pushing OTA

# Channel & Group
export OTA_CHANNEL=-1001331597794
export OTA_GROUP=-1001279894967

# Token
export TELEGRAM_TOKEN=${BOT_API_TOKEN}

# Send to main group
tg_groupcast() {
    "${TELEGRAM}" -c "${OTA_GROUP}" -H \
    "$(
		for POST in "${@}"; do
			echo "${POST}"
		done
    )"
}

tg_imagecaptioncast() {
    "${TELEGRAM}" -i ota_scripts/images/update.jpg -c "${OTA_GROUP}" -H \
    "$(
                for POST in "${@}"; do
                        echo "${POST}"
                done
    )"
}

export -f tg_groupcast
export -f tg_channelcast
export -f tg_imagecaptioncast
