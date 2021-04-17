#!/bin/bash
# Telegram helpers for pushing OTA

# Send to main group
tg_groupcast() {
    "${TELEGRAM}" -c "${OTA_GROUP}" -H \
    "$(
		for POST in "${@}"; do
			echo "${POST}"
		done
    )"
}

tg_channelcast() {
    "${TELEGRAM}" -c "${OTA_CHANNEL}" -H \
    "$(
                for POST in "${@}"; do
                        echo "${POST}"
                done
    )"
}

export -f tg_groupcast
export -f tg_channelcast
