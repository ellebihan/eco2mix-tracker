import requests
import pandas as pd
from datetime import datetime, timedelta

API_KEY = "TA_CLE_API"
HEADERS = {"x-api-key": API_KEY}

def get_eco2mix_data(date: str):
    url = "https://digital.iservices.rte-france.com/open_api/eco2mix-national-tr/raw"
    params = {
        "start_date": f"{date}T00:00:00Z",
        "end_date": f"{date}T23:59:00Z"
    }
    response = requests.get(url, headers=HEADERS, params=params)
    response.raise_for_status()
    return response.json()

def flatten_data(raw_data):
    records = raw_data["intervals"]
    output = []
    for r in records:
        ts = r["start_date"]
        values = r["values"][0]  # une seule ligne par pas de temps
        values["timestamp"] = ts
        output.append(values)
    return pd.DataFrame(output)

# Test avec la veille
yesterday = (datetime.utcnow() - timedelta(days=1)).strftime("%Y-%m-%d")
raw = get_eco2mix_data(yesterday)
df = flatten_data(raw)
print(df.head())