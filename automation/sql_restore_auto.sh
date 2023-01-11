#!/bin/sh
echo "Restore: restore database name, .sql file"

if [ -f $2 ]; then
    dbname=$(/usr/local/mysql/bin/mysql -e "SELECT SCHEMA_NAME FROM INFORMATION_SCHEMA.SCHEMATA WHERE SCHEMA_NAME = '$1'" | grep $1)
    if [ $1 != $dbname ]; then
        echo "created db as it didn't exist"
        /usr/local/mysql/bin/mysql -e "create database $1"
    fi
    /usr/local/mysql/bin/mysql -e "use $1"
    /usr/local/mysql/bin/mysql $1 < $2
else
    echo ".sql file doesn't exist"
fi
