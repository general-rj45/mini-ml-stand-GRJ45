from datetime import datetime
from airflow import DAG
from airflow.contrib.operators.kubernetes_pod_operator import KubernetesPodOperator

default_args = {
    'owner': 'airflow',
    'depends_on_past': False,
    'start_date': datetime(2023, 6, 24),
    'retries': 1,
}

dag = DAG('kubernetes_hello_world', default_args=default_args, schedule_interval=None)

task = KubernetesPodOperator(
    task_id='hello_world_task',
    name='hello-world-pod',
    namespace='airflow',
    image='busybox:latest',
    cmds=['echo', 'Hello, World!'],
    dag=dag
)