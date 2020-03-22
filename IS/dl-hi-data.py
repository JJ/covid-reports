#!/usr/bin/env python

import requests
import re
import json

url = "https://e.infogram.com/8b33ac5e-6d56-40bc-8d3b-e6a6c941b94e"

response = requests.get(url)
if response.status_code == 200:
    wholePage = response.text
else:
    exit("Page not found")

scripts = re.search('<script.*>(.+)</script>', wholePage )
json = re.search('window.infographicData=(.+);',scripts.group(1)).group(1)
data = json.loads(json)
print(data)
