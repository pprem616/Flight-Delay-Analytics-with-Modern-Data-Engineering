from airflow import DAG
from airflow.operators.bash import BashOperator
from datetime import datetime

with DAG(
    "dbt_models",
    schedule=None,
    start_date=datetime(2023, 1, 1),
    catchup=False,
    tags=["dbt"]
) as dag:

    run_dbt = BashOperator(
        task_id="run_dbt",
        bash_command="cd /opt/airflow/dbt/flights_analytics_dbt && dbt seed && dbt run",
    )
