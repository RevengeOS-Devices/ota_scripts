import json
import sys

with open('maintainers.json', 'r') as f:
	deviceList = json.load(f)

device = deviceList[(sys.argv[1])]
print(device[(sys.argv[2])])
