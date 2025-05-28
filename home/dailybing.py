#!/usr/bin/env python
import requests
import json
import subprocess
import shutil
import os

REGION = 'en-US'

BASE_URL = f'https://bing.biturl.top/?resolution=UHD&format=json&index=0&mkt={REGION}'
BASE_PATH = os.path.expanduser('~/backgrounds/')
CURRENT_BACKGROUND = BASE_PATH + 'current.jpg'

u = requests.get(BASE_URL).json()

r = requests.get(u['url'], stream=True)
name = u['url'].split('=')[-1]

filename = os.path.join(BASE_PATH, name)
with open(filename, 'wb') as file:
    for chunk in r.iter_content(chunk_size=8192):
        file.write(chunk)


shutil.copy(filename, CURRENT_BACKGROUND)
subprocess.run(['hyprctl', 'hyprpaper', 'reload', ',' + CURRENT_BACKGROUND])
