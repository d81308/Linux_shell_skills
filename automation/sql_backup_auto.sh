#!/bin/sh
# The above line tells the interpreter this code needs to be run as a shell scri$

echo "please key in database name, backup folder"

# Set the database name to a variable.
dbname=$(/usr/local/mysql/bin/mysql -e "SELECT SCHEMA_NAME FROM INFORMATION_SCHEMA.SCHEMATA WHERE SCHEMA_NAME = '$1'" | grep $1)

# This will be printed on to the screen. In the case of cron job, it will be pri$
echo "Pulling Database: This may take a few minutes"

# Number of days to store the backup
keep_day=30

## create backup auto
#choose backup location, if not exists
if [ ! -d $2 ]; then
    mkdir $2
fi

# choose target db, if not exists
if [ $1 == $dbname ]; then
    sqlfile=$2/$1-$(date +%d-%m-%Y).sql
    if /usr/local/mysql/bin/mysqldump -u root -pd9982951 $1 > $sqlfile ; then
    echo 'Sql dump created'
    else
        echo 'Error creating backup!'
    fi
else
    echo "Database doesn't exist"
fi

# Delete old backups
find $backupfolder -mtime +$keep_day -delete
