source activate airflow-tutorials

# airflow needs a home, ~/airflow is the default,
# but you can lay foundation somewhere else if you prefer
# (optional)
export AIRFLOW_HOME=/Users/jianlin/airflow-tutorials

# initialize the database
airflow db init

airflow users create \
    --username admin \
    --firstname Peter \
    --lastname Parker \
    --role Admin \
    --email spiderman@superhero.org

# start the web server, default port is 8080
airflow webserver --port 8080

# start the scheduler
# open a new terminal or else run webserver with ``-D`` option to run it as a daemon
airflow scheduler

# visit localhost:8080 in the browser and use the admin account you just
# created to login. Enable the example_bash_operator dag in the home page


## started with airflow
# view all dags
airflow dags list

# view tasks in dag
airflow tasks list <dag>

#unpause the dag job, activate
airflow dags unpause <dag>

#pause the dag job, stop
airflow dags pause <dag>

