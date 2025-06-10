# sync_to_azure.py
import requests
import time
import json
import os

AZURE_URL = "https://gr-system-<اسم_موقعك>.azurewebsites.net/api/update"
LOCAL_FILE = "backend/latest_prediction.json"

while True:
    try:
        if os.path.exists(LOCAL_FILE):
            with open(LOCAL_FILE, "r") as f:
                prediction = json.load(f)

            res = requests.post(AZURE_URL, json=prediction)
            print("✅ Synced to Azure:", prediction, "| Response:", res.status_code)
        else:
            print("⚠️ File not found:", LOCAL_FILE)

    except Exception as e:
        print("❌ Error syncing:", e)

    time.sleep(2)  # كل 2 ثانية
