import os
import json

# Parse json information

DEVICE = os.getenv('DEVICE')
DEVICE_JSON = os.path.join(str(DEVICE), "device.json")

with open(DEVICE_JSON, 'r') as f:
    DEVICE_DICT = json.load(f)

os.environ['DONATE_URL'] = DEVICE_DICT['donate_url']
os.environ['FILENAME'] = DEVICE_DICT['filename']
os.environ['URL'] = DEVICE_DICT['url']

