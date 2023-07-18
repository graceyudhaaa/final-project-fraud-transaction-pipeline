import logging

from airflow import DAG
from airflow.utils.dates import days_ago
from airflow.operators.empty import EmptyOperator
from airflow.operators.bash import BashOperator
from airflow.operators.python import PythonOperator

import pyarrow.csv as pv
import pyarrow.parquet as pq

from datetime import timedelta

path_to_local_home = "/opt/airflow"
# dataset_file = "PS_20174392719_1491204439457_log.csv"
parquet_file = "online_transaction.parquet"

def format_to_parquet(ti):
    filename = ti.xcom_pull(task_ids='download_dataset')
    if not filename.endswith('.csv'):
        logging.error("Can only accept source files in CSV format, for the moment")
        return
    table = pv.read_csv(f"{path_to_local_home}/datasets/{filename}")
    return pq.write_table(table, f"{path_to_local_home}/datasets/{parquet_file}")

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
        bash_command="download.sh",
        # xcom_push = True
    )

    format_to_parquet_task = PythonOperator(
        task_id="format_to_parquet_task",
        python_callable=format_to_parquet,
        # op_kwargs={
        #     "src_file": f"{path_to_local_home}/datasets/{dataset_file}",
        # },
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

    start >> download_dataset >> format_to_parquet_task >>\
    upload_to_gcs >> create_bq_table >>\
    bq_partition_clustering >> end

