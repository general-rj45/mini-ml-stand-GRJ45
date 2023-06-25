from datetime import datetime
from airflow import DAG
from airflow.contrib.operators.kubernetes_pod_operator import KubernetesPodOperator

default_args = {
    'owner': 'airflow',
    'depends_on_past': False,
    'start_date': datetime(2023, 6, 24),
    'retries': 1,
}

dag = DAG('test-mlflow-ci', default_args=default_args, schedule_interval=None)

task = KubernetesPodOperator(
    task_id='test_mlflow',
    name='test_mlflow',
    namespace='airflow',
    image='192.168.1.227:32339/gitea_admin/best-repo-ci:47',
    dag=dag
)