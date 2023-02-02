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
    dag_id='ETL_Server_Access_Log_Processing',
    default_args=default_args,
    description='Test dag',
    schedule_interval=timedelta(days=1),
)

# define the tasks

#download task
download_file = BashOperator(
    task_id='download_file',
    bash_command='wget -O /Users/jianlin/airflow-tutorials/dags/web-server-access-log.txt "https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBM-DB0250EN-SkillsNetwork/labs/Apache%20Airflow/Build%20a%20DAG%20using%20Airflow/web-server-access-log.txt"',
    dag=dag,
)

#extract task
extract = BashOperator(
    task_id='extract',
    bash_command='cut -d"#" -f1-4 /Users/jianlin/airflow-tutorials/dags/web-server-access-log.txt > /Users/jianlin/airflow-tutorials/dags/extracted.txt',
    dag=dag,
)

#transform task
transform = BashOperator(
    task_id='transform',
    bash_command='tr "[a-z]" "[A-Z]" < /Users/jianlin/airflow-tutorials/dags/extracted.txt > /Users/jianlin/airflow-tutorials/dags/capitalized.txt',
    dag=dag,
)

#load task
load = BashOperator(
    task_id='load',
    bash_command='zip log.zip capitalized.txt',
    dag=dag,
)

#--------------------------------------------------------
## task pipeline
download >> extract >> transform >> load