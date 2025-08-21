
from airflow import DAG
from airflow.operators.bash import BashOperator # type: ignore
from airflow.operators.python import PythonOperator # type: ignore
import sys
sys.path.append("/opt/airflow")
from datetime import datetime
from scripts.extract import run_extraction_for_airflow
from scripts.load import run_loading_for_airflow
# from eco2mix.transform import dbt_task

with DAG(
    dag_id="eco2mix_daily_pipeline",
    start_date=datetime(2025, 1, 1),
    schedule_interval="@daily",
    catchup=False,
    tags=['daily', 'rte'],
) as dag:

    extract_rte = PythonOperator(
        task_id="extract_rte",
        python_callable=run_extraction_for_airflow,
        op_kwargs={"domain": "rte", "config_path": "/opt/airflow/datasources.yaml"},
    )
    
    load_rte = PythonOperator(
        task_id="load_rte",
        python_callable=run_loading_for_airflow,
        op_kwargs={"domain": "rte", "config_path": "/opt/airflow/datasources.yaml"},
    )

    dbt_run = BashOperator(
        task_id='dbt_run',
        bash_command=(
            "cd /opt/airflow/dbt_elsa && "
            "dbt run --select bronze && "
            "dbt run --select silver"
        )
    )

    dbt_test = BashOperator(
        task_id='dbt_test',
        bash_command='cd /opt/airflow/dbt_elsa && dbt test'
    )

    extract_rte >> load_rte >> dbt_run >> dbt_test