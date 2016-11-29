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

# dropbox upload
# https://github.com/andreafabrizi/Dropbox-Uploader
dropbox_enable=1                                   # 1 = On / 0 = Off
dropbox_path_config="/root/.dropbox_uploader"
dropbox_path_uploader="/root/dropbox_uploader.sh"
dropbox_path_folder="/backup"                      # backup folder on dropbox
dropbox_delete_date=$(date --date="-1 day" +"%Y-%m-%d")

######################################################################################################
############## Script Logic Starts here ##############################################################
######################################################################################################

# Set default file permissions
umask 177

# Dump database into SQL file
echo "Start DB Backup"
mysqldump --user=${user} --password=${password} --host=${host} ${db_name} > ${backup_path}/${db_name}-${date}.sql
echo "Backup complete"

# compress the SQL file
cd ${backup_path}
echo "Comperess the sql file"
gzip -f -${compressLevel} ${db_name}-${date}.sql

# Delete files older than 10 days (only .sql.gz files)
echo "Delete old .sql.gz files"
find ${backup_path}/* -name '*.sql.gz' -mtime +10 -exec rm {} \;

# check dropbox upload
if test ${dropbox_enable} == 1
    then
        # upload to dropbox
        bash ${dropbox_path_uploader} -f ${dropbox_path_config} upload ${backup_path}/${db_name}-${date}.sql.gz ${dropbox_path_folder}
        # delete old uploads
        echo "Try to delete "
        bash ${dropbox_path_uploader} -f ${dropbox_path_config} delete ${dropbox_path_folder}/${db_name}-${dropbox_delete_date}.sql.gz
    else
        echo "Dropbox upload not enabled"
fi

echo "Run complete."