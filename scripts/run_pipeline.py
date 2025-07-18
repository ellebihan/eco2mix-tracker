from fetch_data import fetch_eco2mix_data_for_date
from parse_data import parse
from load import load_data
from datetime import datetime, timedelta

# Récupération des données de la veille
date = (datetime.now - timedelta(days=1)).strftime("%Y-%m-%d")
df_raw = fetch_eco2mix_data_for_date(date)
df_clean = parse(df_raw)
load_data(df_clean)
