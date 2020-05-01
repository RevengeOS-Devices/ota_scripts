import os
import json
import sys

# Parse json information

DEVICE = os.getenv('DEVICE')
DEVICE_JSON = os.path.join(str(DEVICE), "device.json")

with open(DEVICE_JSON, 'r') as f:
    DEVICE_DICT = json.load(f)

print(str(DEVICE_DICT[sys.argv[1]]))
