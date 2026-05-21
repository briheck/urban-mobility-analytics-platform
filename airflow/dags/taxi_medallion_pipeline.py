from datetime import datetime

from airflow import DAG
from airflow.operators.bash import BashOperator


PROJECT_ROOT = "/opt/airflow/project"
DBT_PROJECT_DIR = f"{PROJECT_ROOT}/dbt/urban_mobility"


with DAG(
    dag_id="taxi_medallion_pipeline",
    start_date=datetime(2025, 1, 1),
    schedule=None,
    catchup=False,
    tags=["portfolio", "nyc_taxi", "medallion"],
) as dag:

    ingest_yellow_taxi = BashOperator(
        task_id="ingest_yellow_taxi_to_bronze",
        bash_command=f"cd {PROJECT_ROOT} && python scripts/ingest_to_bronze.py",
    )

    ingest_taxi_zones = BashOperator(
        task_id="ingest_taxi_zones_to_bronze",
        bash_command=f"cd {PROJECT_ROOT} && python scripts/ingest_taxi_zones_to_bronze.py",
    )

    run_dbt_models = BashOperator(
        task_id="run_dbt_models",
        bash_command=f"cd {DBT_PROJECT_DIR} && dbt run",
    )

    run_dbt_tests = BashOperator(
        task_id="run_dbt_tests",
        bash_command=f"cd {DBT_PROJECT_DIR} && dbt test",
    )

    [ingest_yellow_taxi, ingest_taxi_zones] >> run_dbt_models >> run_dbt_tests