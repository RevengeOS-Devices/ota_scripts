#!/bin/bash
# Check if last file was just maintainers.json

CHECK=$(git diff --name-only HEAD~ .)
if [[ CHECK == "maintainers.json" ]]; then
	exit 1
fi
