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
    dag_id='test_etl-project_multi-sources',
    default_args=default_args,
    description='the final assignment project, do the toll-data ETL automation',
    schedule_interval=timedelta(minutes=1),
)

## define the tasks

# create unzip task
download_file = BashOperator(
    task_id='download_file',
    bash_command='/Users/jianlin/airflow-tutorials/dags/project_sixth-step-dag/staging/download.sh',
    dag=dag,
)

# extracted phase
extract_data_from_csv = BashOperator(
	task_id='extract_data_from_csv',
	bash_command='/Users/jianlin/airflow-tutorials/dags/project_sixth-step-dag/staging/extract_header_csv.sh',
	dag=dag,
)

extract_data_from_tsv = BashOperator(
	task_id='extract_data_from_tsv',
	bash_command='/Users/jianlin/airflow-tutorials/dags/project_sixth-step-dag/staging/extract_header_tsv.sh',
	dag=dag,
)

extract_data_from_fixed_width = BashOperator(
	task_id='extract_data_from_fixed_width',
	bash_command='/Users/jianlin/airflow-tutorials/dags/project_sixth-step-dag/staging/extract_header_fix.sh',
	dag=dag,
)

# consolidate_data
consolidate_data = BashOperator(
	task_id='consolidate_data',
	bash_command='/Users/jianlin/airflow-tutorials/dags/project_sixth-step-dag/staging/paste_files.sh',
	dag=dag,
)

# transform phase
transform_data = BashOperator(
	task_id='transform_data',
	bash_command='/Users/jianlin/airflow-tutorials/dags/project_sixth-step-dag/staging/transform_upper.sh',
	dag=dag,
)


#--------------------------------------------------------
## task pipeline
download_file >> extract_data_from_csv >> extract_data_from_tsv >> extract_data_from_fixed_width >> consolidate_data >> transform_data