from pathlib import Path
import pandas as pd
import streamlit as st

from dash import Dash, dcc, html, Input, Output
import plotly.express as px
import calendar
from datetime import datetime


def preprocess_data(dataframe):
    dataframe['date'] = dataframe['datetime'].apply(lambda x: x.split()[0])
    dataframe['hour'] = dataframe['datetime'].apply(lambda x: x.split()[1].split(':')[0])
    dataframe['weekday'] = dataframe['date'].apply(
        lambda date_string: calendar.day_name[datetime.strptime(date_string, '%Y-%m-%d').weekday()])
    dataframe['month'] = dataframe['date'].apply(
        lambda date_string: calendar.month_name[datetime.strptime(date_string, '%Y-%m-%d').month])
    dataframe['season'] = dataframe['season'].map({1: 'Spring', 2: 'Summer', 3: 'Fall', 4: 'Winter'})
    return dataframe

@st.cache_data
def load_data():
   data_path = Path() / 'data/imports/rte/eco2mix_rte_2025-07-01.csv'
   data = pd.read_csv(data_path)
   return data

df = load_data()

'''
df_preprocessed = preprocess_data(df.copy())
mean_counts_by_hour = pd.DataFrame(df_preprocessed.groupby(['hour', 'season'], sort=True)['count'].mean()).reset_index()
'''
mean_counts_by_hour = pd.DataFrame(df.groupby('Heures', sort=True)['count'].mean()).reset_index()
fig1 = px.bar(mean_counts_by_hour, x='hour', y='count', color='season', height=400)
barplot_chart = st.write(fig1)


st.write(df)