#!/usr/bin/env bash

######################################################################################################
############## Configuration  ########################################################################
######################################################################################################

# Database credentials
user=""
password=""
host=""
db_name=""

# Other options
backup_path="/home/<user>/backup"
date=$(date +"%d-%b-%Y")
compressLevel=9

######################################################################################################
############## Script Logik Starts here ##############################################################
######################################################################################################

# Set default file permissions
umask 177

# Dump database into SQL file
mysqldump --user=$user --password=$password --host=$host $db_name > $backup_path/$db_name-$date.sql

# compress the SQL file
cd $backup_path
gzip -f -$compressLevel $db_name-$date.sql

# Delete files older than 30 days
find $backup_path/* -name *.sql -mtime +30 -exec rm {} \;