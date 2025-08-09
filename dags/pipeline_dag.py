from airflow import DAG
from airflow.operators.python import PythonOperator
from airflow.providers.google.cloud.hooks.gcs import GCSHook
from airflow.providers.google.cloud.transfers.gcs_to_bigquery import GCSToBigQueryOperator
from datetime import datetime
import os

BUCKET_NAME = os.environ.get("GCP_BUCKET_NAME") 
LOCAL_FOLDER = "/opt/airflow/local_data"
PROJECT_ID = os.environ.get("GCP_PROJECT_ID") 
DATASET_ID = "airflow_bq_dataset"
PARQUET_FILE_NAME = "features_added.parquet"
TABLE_NAME = "raw_flight_data" 

# Upload to gcs
def upload_to_gcs(**kwargs):
    gcs_hook = GCSHook(gcp_conn_id='google_cloud_default')
    parquet_path = os.path.join(LOCAL_FOLDER, PARQUET_FILE_NAME)

    try:
        gcs_hook.upload(
            bucket_name=BUCKET_NAME,
            object_name=PARQUET_FILE_NAME,
            filename=parquet_path
        )
        print(f"Uploaded {PARQUET_FILE_NAME} to GCS")
    except Exception as e:
        print(f"Gagal upload {PARQUET_FILE_NAME}: {e}")

# Cleanup 
def cleanup_local_files(**kwargs):
    for file_name in os.listdir(LOCAL_FOLDER):
        if file_name.endswith(".parquet"):
            file_path = os.path.join(LOCAL_FOLDER, file_name)
            try:
                os.remove(file_path)
                print(f"Deleted {file_name}")
            except Exception as e:
                print(f"Gagal hapus {file_name}: {e}")

# Definisi DAG
with DAG(
    dag_id="upload_data",
    start_date=datetime(2023, 1, 1),
    schedule=None,
    catchup=False,
    render_template_as_native_obj=True,
) as dag:

    task_upload = PythonOperator(
        task_id="upload_to_gcs",
        python_callable=upload_to_gcs,
    )

    task_load_bq = GCSToBigQueryOperator(
        task_id="load_to_bigquery",
        bucket=BUCKET_NAME,
        source_format="PARQUET",
        autodetect=True,
        write_disposition="WRITE_TRUNCATE",
        gcp_conn_id="google_cloud_default",
        source_objects=[PARQUET_FILE_NAME],
        destination_project_dataset_table=f"{PROJECT_ID}.{DATASET_ID}.{TABLE_NAME}",
        email_on_failure=False,
    )

    task_cleanup = PythonOperator(
        task_id="cleanup_local_files",
        python_callable=cleanup_local_files,
    )

    task_upload >> task_load_bq >> task_cleanup
