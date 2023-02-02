#!/usr/bin/env bash
#--------------------------------------------------------------------
## Variables management
# download file information
download_file_name="web-server-access-log.txt.gz"
download_file_url="https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBM-DB0250EN-SkillsNetwork/labs/Bash%20Scripting/ETL%20using%20shell%20scripting/web-server-access-log.txt.gz"

# set path
script_file_path=$(dirname "$0")
download_file_path="$(dirname "$0")/download"
extract_file_path="$(dirname "$0")/extract"
transform_file_path="$(dirname "$0")/transform"

# file_naming
unzip_file_name="web-server-access-log.txt"
extract_file_name="extracted.txt"
transform_file_name="transformed.csv"


#--------------------------------------------------------------------
### File database program

## Create table phase
/Applications/Postgres.app/Contents/Versions/15/bin/psql -p5433 <<EOF
\c etl;

-- drop cell
DROP SCHEMA IF EXISTS etl_access_log CASCADE;
DROP TABLE IF EXISTS etl_access_log.access_log CASCADE;

-- create schema
CREATE SCHEMA etl_access_log;

-- create table
CREATE TABLE etl_access_log.access_log(
	timestamp TIMESTAMP,
	latitude float,
	longitude float,
	visitor_id char(37)
);

EOF

## Download file phase

# if folder not exists
if [ ! -d $download_file_path ]; then
    mkdir $download_file_path
fi

# download the access log file
wget -O $download_file_path/$download_file_name $download_file_url

## Unzip phase
# Unzip the file to extract the .txt file.
gunzip -f $download_file_path/$download_file_name

#--------------------------------------------------------------------
### ETL program

## Extract phase
echo "Extracting data"
# if folder not exists
if [ ! -d $extract_file_path ]; then
    mkdir $extract_file_path
fi

cut -d"#" -f1-4 $download_file_path/$unzip_file_name > $extract_file_path/$extract_file_name

## Transform phase
echo "Transforming data"
# if folder not exists
if [ ! -d $transform_file_path ]; then
    mkdir $transform_file_path
fi

tr "#" "," < $extract_file_path/$extract_file_name > $transform_file_path/$transform_file_name

## Load phase
echo "Loading data"
echo "\c etl;\copy etl_access_log.access_log FROM $transform_file_path/$transform_file_name DELIMITER ',' CSV HEADER;" | /Applications/Postgres.app/Contents/Versions/15/bin/psql -p5433

#--------------------------------------------------------------------
## Check phase
echo "query data"
/Applications/Postgres.app/Contents/Versions/15/bin/psql -p5433 <<EOF
\c etl;
SELECT *
FROM etl_access_log.access_log;
EOF

