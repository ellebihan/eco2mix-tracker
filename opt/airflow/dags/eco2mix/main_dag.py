
from airflow import DAG
from airflow.operators.bash import BashOperator
from airflow.operators.python import PythonOperator
import sys
import os
sys.path.append("/opt/airflow")
from datetime import datetime
from scripts.extract import extract_data
from scripts.load import load_data
# from eco2mix.transform import dbt_task

with DAG(
    dag_id="eco2mix_daily_pipeline",
    start_date=datetime(2025, 1, 1),
    schedule_interval="@daily",
    catchup=False,
    tags=['dbt'],
) as dag:

    extract_rte = PythonOperator(
        task_id="extract_rte",
        python_callable=extract_data,
        op_args=["rte"],  # 👈 correspond au --domain
    )
    
    load_rte = PythonOperator(
        task_id="load_rte",
        python_callable=load_data,
        op_args=["rte"],  # 👈 correspond au --domain
    )

    dbt_run = BashOperator(
        task_id='dbt_run',
        bash_command='cd /opt/airflow/dbt_elsa && dbt run --select bronze && dbt run --select silver'
    )

    dbt_test = BashOperator(
        task_id='dbt_test',
        bash_command='dbt run --project-dir /opt/airflow/dbt_elsa dbt test'
    )

    extract_rte >> load_rte >> dbt_run >> dbt_test