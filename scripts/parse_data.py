# But : mettre le CSV dans un data frame

from pathlib import Path
import pandas as pd

'''
def preprocess_data(dataframe):
    dataframe['date'] = dataframe['datetime'].apply(lambda x: x.split()[0])
    dataframe['hour'] = dataframe['datetime'].apply(lambda x: x.split()[1].split(':')[0])
    dataframe['weekday'] = dataframe['date'].apply(
        lambda date_string: calendar.day_name[datetime.strptime(date_string, '%Y-%m-%d').weekday()])
    dataframe['month'] = dataframe['date'].apply(
        lambda date_string: calendar.month_name[datetime.strptime(date_string, '%Y-%m-%d').month])
    dataframe['season'] = dataframe['season'].map({1: 'Spring', 2: 'Summer', 3: 'Fall', 4: 'Winter'})
    return dataframe
'''

def load_data():
   data_path = Path() / 'data/imports/eco2mix/eco2mix_rte_2025-07-01.csv'
   data = pd.read_csv(data_path)
   return data

df = load_data()
# df.to_sql("production_journaliere", engine, if_exists="append", index=False)