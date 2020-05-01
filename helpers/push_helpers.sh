#!/bin/bash
# Telegram helpers for pushing OTA

# Channel & Group
export OTA_CHANNEL=1
export OTA_GROUP=-1001279894967

# Token
export TELEGRAM_TOKEN=${BOT_API_TOKEN}

# Send to channel
tg_channelcast() {
    "${TELEGRAM}" -c "${OTA_CHANNEL}" -H \
    "$(
		for POST in "${@}"; do
			echo "${POST}"
		done
    )"
}

# Send to main group
tg_groupcast() {
    "${TELEGRAM}" -c "${OTA_GROUP}" -H \
    "$(
		for POST in "${@}"; do
			echo "${POST}"
		done
    )"
}
