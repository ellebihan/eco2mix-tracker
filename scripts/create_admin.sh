#!/bin/bash

airflow db upgrade

airflow users create \
  --username airflow \
  --password airflow \
  --firstname Admin \
  --lastname User \
  --role Admin \
  --email elsa.lebihan@proton.me

exec "$@"