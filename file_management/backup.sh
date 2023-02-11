#!/bin/bash

# This checks if the number of arguments is correct
# If the number of arguments is incorrect ( $# != 2) print error message and exit
if [[ $# != 2 ]]
then
  echo "backup.sh target_directory_name destination_directory_name"
  exit
fi

# This checks if argument 1 and argument 2 are valid directory paths
if [[ ! -d $1 ]] || [[ ! -d $2 ]]
then
  echo "Invalid directory path provided"
  exit
fi

# [TASK 1]
cd .
targetDirectory=$1
destinationDirectory=$(pwd)

# [TASK 2]
echo "target dir is: $targetDirectory"
echo "destination dir is $destinationDirectory"

# [TASK 3]
currentTS=$(date "+%Y-%m-%d")
echo "current date:$currentTS"
# [TASK 4]
backupFileName="backup-[$currentTS].tar.gz"
echo "backupfilename:$backupFileName"

# We're going to:
  # 1: Go into the target directory
  # 2: Create the backup file
  # 3: Move the backup file to the destination directory

# To make things easier, we will define some useful variables...

# [TASK 5]
origAbsPath=$(pwd)

# [TASK 6]
cd $destinationDirectory # <-
destDirAbsPath=$(pwd)

# [TASK 7]
cd $origAbsPath # <-
cd $targetDirectory # <-

# [TASK 8]
num_cur=$(date --date="$currentTS" '+%s')
num_y_cur=$(($num_cur - 24 * 60 * 60))
yesterdayTS=$(date --date=@"$num_y_cur" "+%Y-%m-%d")


declare -a toBackup

for file in $(ls) # [TASK 9]
do
  # [TASK 10]
  if ((`date -r $file +%s` > $num_y_cur))
  then
   toBackup+=($file) # [TASK 11]
   echo "tar file is:$file"
  fi
done

# [TASK 12]
tar -czvf $backupFileName ${toBackup[@]}
# [TASK 13]
mv $backupFileName $destinationDirectory
# Congratulations! You completed the final project for this course!
