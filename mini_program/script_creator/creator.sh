#!/usr/bin/env bash

## the function using manual:
# variable: new_script_name

new_script_name=$1
file_path=$(dirname "$0")

echo -e "<$new_script_name> is created in: \n <$file_path>"

touch $file_path/$new_script_name

chmod +x $file_path/$new_script_name
