# Dockerfile
FROM apache/airflow:2.9.1-python3.10

# Installer dbt avec le connecteur PostgreSQL (modifie selon ton besoin)
RUN pip install --no-cache-dir dbt-core dbt-postgres

USER root
RUN apt-get update && apt-get install -y git
# Créer le dossier .dbt pour y monter profiles.yml proprement
RUN mkdir -p /home/airflow/.dbt && chown -R airflow: /home/airflow/.dbt
USER airflow