def parse(df_raw):
    cols = [
        "date", "heure", "nucleaire", "eolien", "solaire",
        "hydraulique", "gaz", "charbon", "consommation", "fioul",
        "bioenergies", "ech_physiques", "taux_co2"
    ]
    df = df_raw.copy()
    for col in cols:
        if col not in df:
            df[col] = None
    df = df[cols]
    return df
