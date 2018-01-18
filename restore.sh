#!/bin/bash

site=$1
archive=$2
backup=$3

if [ ${archive: -4} == ".tar" ] && [ ${backup: -4} == ".sql" ]; then

#Restore wordpress
tar -xvf $archive

# WP-config
db_name=`cat $site/wp-config.php | grep DB_NAME | cut -d \' -f 4`
db_user=`cat $site/wp-config.php | grep DB_USER | cut -d \' -f 4`
db_pass=`cat $site/wp-config.php | grep DB_PASSWORD | cut -d \' -f 4`
db_host=`cat $site/wp-config.php | grep DB_HOST | cut -d \' -f 4`

#Create mysql database
#mysql -uroot <<EOF
#CREATE DATABASE $site
#EOF

# Restore database
if [ "$db_host" == "localhost" ]; then
mysql -p -u$db_user --password=$db_pass $db_name < $backup

else
mysql -p -u$db_user --password=$db_pass --host=$db_host $db_name < $backup

fi

else
echo "Invalid argument"
exit 1

fi
