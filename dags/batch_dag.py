from airflow import DAG
from airflow.utils.dates import days_ago
from airflow.operators.empty import EmptyOperator
from airflow.operators.bash import BashOperator

from datetime import timedelta

default_args = {
    "owner": "airflow",
    "start_date": days_ago(1),
    "retries": 1,
    "retry_delay": timedelta(minutes=5)
}

with DAG(
    dag_id="batch_workflow",
    default_args=default_args,
    schedule_interval="@weekly"
) as dag:
    start = EmptyOperator(
        task_id="start"
    )

    download_dataset = BashOperator(
        task_id="download_dataset",
        bash_command="download.sh"
    )

    unzip_file = EmptyOperator(
        task_id="unzip_file"
    )

    upload_to_gcs = EmptyOperator(
        task_id="upload_to_gcs"
    )

    create_bq_table = EmptyOperator(
        task_id="create_bq_table"
    )

    bq_partition_clustering = EmptyOperator(
        task_id="bq_partition_clustering"
    )

    end = EmptyOperator(
        task_id="end"
    )

    start >> download_dataset >>\
    unzip_file >> upload_to_gcs >>\
    create_bq_table >> bq_partition_clustering >>\
    end

