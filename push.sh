#!/bin/bash

URL=$(python3 ota_scripts/helpers/parse_info.py url)
FILENAME=$(python3 ota_scripts/helpers/parse_info.py filename)
DONATE_URL=$(python3 ota_scripts/helpers/parse_info.py donate_url)
tg_groupcast "Latest device: <code>${DEVICE}</code>" \
             "URL: <code>${URL}</code>" \
             "Filename: <code>${FILENAME}</code>" \
             "Donate URL: <code>${DONATE_URL}</code>"
