## import library

#for retry_delay, schedule-time
from datetime import timedelta
#the DAG object
from airflow import DAG
#the bash-operator, need this to write tasks
from airflow.operators.bash_operator import BashOperator
#make scheduling easy
from airflow.utils.dates import days_ago

#--------------------------------------------------------
## defining DAG arguments
default_args = {
    'owner': 'Neil Wu',
    'start_date': days_ago(0),
    'email': ['d81308@gmail.com'],
    'email_on_failure': True,
    'email_on_retry': True,
    'retries': 1,
    'retry_delay': timedelta(minutes=5),
}

## define the DAG
dag = DAG(
    dag_id='my-first-dag',
    default_args=default_args,
    description='Test dag',
    schedule_interval=timedelta(days=1),
)

# define the tasks
#extract task
extract = BashOperator(
    task_id='extract',
    bash_command='cut -d":" -f1,3,6 /etc/passwd > /Users/jianlin/airflow-tutorials/dags/extracted-data.txt',
    dag=dag,
)

#transform task
transform_and_load = BashOperator(
    task_id='transform_and_load',
    bash_command='tr ":" "," < /Users/jianlin/airflow-tutorials/dags/extracted-data.txt > /Users/jianlin/airflow-tutorials/dags/transformed-data.txt',
    dag=dag,
)

#--------------------------------------------------------
## task pipeline
extract >> transform_and_load

