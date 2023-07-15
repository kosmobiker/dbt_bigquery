"""
This script is used to trigger dbt job using Airflow dbt Cloud Operators.
See the reference https://airflow.apache.org/docs/apache-airflow-providers-dbt-cloud/stable/operators.html
"""
from datetime import datetime
from airflow.models import DAG
from airflow.operators.empty import EmptyOperator
from airflow.providers.dbt.cloud.operators.dbt import (
    DbtCloudGetJobRunArtifactOperator,
    DbtCloudRunJobOperator,
)
from airflow.utils.edgemodifier import Label
from airflow.providers.dbt.cloud.sensors.dbt import DbtCloudJobRunSensor

DAG_ID = "test_dbt_cloud_job"
ACCOUNT_ID = 179955
JOB_ID = 381152

with DAG(
    dag_id=DAG_ID,
    default_args={"dbt_cloud_conn_id": "dbt", "account_id": ACCOUNT_ID},
    start_date=datetime(2023, 1, 1),
    schedule=None,
    catchup=False,
) as dag:
    begin = EmptyOperator(task_id="begin")
    end = EmptyOperator(task_id="end")
    trigger_job_run1 = DbtCloudRunJobOperator(
        task_id="trigger_job_run1",
        job_id=JOB_ID,
        check_interval=10,
        timeout=300,
    )
    get_run_results_artifact = DbtCloudGetJobRunArtifactOperator(
        task_id="get_run_results_artifact",
        run_id=trigger_job_run1.output,
        path="run_results.json"
    )
    job_run_sensor = DbtCloudJobRunSensor(
        task_id="job_run_sensor", 
        run_id=trigger_job_run1.output, 
        timeout=20
    )

begin >> Label("No async wait") >> trigger_job_run1
[get_run_results_artifact, job_run_sensor] >> end