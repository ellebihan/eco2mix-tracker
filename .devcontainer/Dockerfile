# Utilise une image Airflow officielle avec Python 3.10
FROM apache/airflow:2.9.1-python3.10

USER airflow

# Installe dbt pour Postgres
RUN pip install --no-cache-dir dbt-postgres

# (optionnel) Crée le dossier .dbt pour y monter profiles.yml
RUN mkdir -p /home/airflow/.dbt && chown -R airflow: /home/airflow/.dbt