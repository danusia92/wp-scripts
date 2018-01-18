#!/bin/bash
 
site=${1%/}
backup_path=`pwd`
date=$(date +"%F"_"%H-%M-%S")
file="$site.$date.tar"

db_name=`cat $site/wp-config.php | grep DB_NAME | cut -d \' -f 4`
db_user=`cat $site/wp-config.php | grep DB_USER | cut -d \' -f 4`
db_pass=`cat $site/wp-config.php | grep DB_PASSWORD | cut -d \' -f 4`
db_host=`cat $site/wp-config.php | grep DB_HOST | cut -d \' -f 4`

#Archive wordpress
tar -cvf $site.$date.tar $site

# Dump database into SQL file
if [ "$db_host" == "localhost" ]; then
	mysqldump --user=$user --password=$password $db_name > $backup_path/$db_name-$date.sql
else
	mysqldump --user=$user --password=$password --host=$host $db_name > $backup_path/$db_name-$date.sql
fi

exit 
