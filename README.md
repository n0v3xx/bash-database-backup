# bash-database-backup
Simple Bash Script to Backup a Database

Modify the options in db-backup.sh to your needs!

Run for the backup:
    
    ./db-backup.sh
    
### Backup to Dropbox
If you want to use the dropbox upload. Install dropbox uploader (https://github.com/andreafabrizi/Dropbox-Uploader)

    curl "https://raw.githubusercontent.com/andreafabrizi/Dropbox-Uploader/master/dropbox_uploader.sh" -o dropbox_uploader.sh
    
Run uploader and follow install instructions.

    chmod +x dropbox_uploader.sh
    ./dropbox_uploader.sh

Change dropbox uploader settings in db-backup.sh. Thats it.

### Cronjob
If you want the backup every day? Use crontab.

    crontab -e
    # Add the following line
    0 1 * * * /path/to/script/db-backup.sh &> /dev/null

## Changelog

### 29.11.2016:
* Add upload to dropbox with dropbox_uploader