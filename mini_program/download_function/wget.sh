#!/usr/bin/env bash

## In this mini-program
#  you can put this wget.sh file into <your-project-folder>.
#  the program will generate new download folder, if not exist.
#  you have setup the file_name, url. In the shell script variable, not function key in


## Download file phase

# download file information
download_file_name="web-server-access-log.txt.gz"
download_file_url="https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBM-DB0250EN-SkillsNetwork/labs/Bash%20Scripting/ETL%20using%20shell%20scripting/web-server-access-log.txt.gz"

# set path

script_file_path=$(dirname "$0")
download_file_path="$(dirname "$0")/download"
echo $download_file_path

# if folder not exists
if [ ! -d $download_file_path ]; then
    mkdir $download_file_path
fi

# download the access log file
wget -O $download_file_path/$download_file_name $download_file_url
