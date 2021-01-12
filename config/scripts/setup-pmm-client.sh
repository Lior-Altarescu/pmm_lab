#! /bin/bash

set -x

while true; do
mysql -h mysql-57 -u root -p${MYSQL_ROOT_PASSWORD} <<EOFMYSQL
CREATE USER IF NOT EXISTS '${PMM_USER}'@'%' IDENTIFIED BY '${PMM_PASSWORD}' WITH MAX_USER_CONNECTIONS 10;
GRANT SELECT, PROCESS, SUPER, REPLICATION CLIENT, RELOAD ON *.* TO '${PMM_USER}'@'%';
    
EOFMYSQL

mysql -h mysql-8 -u root -p${MYSQL_ROOT_PASSWORD} <<EOFMYSQL
CREATE USER IF NOT EXISTS '${PMM_USER}'@'%'IDENTIFIED WITH mysql_native_password BY '${PMM_PASSWORD}' WITH MAX_USER_CONNECTIONS 10;
GRANT SELECT, PROCESS, SUPER, REPLICATION CLIENT, RELOAD ON *.* TO '${PMM_USER}'@'%';
    
EOFMYSQL


if [ $? -eq 0 ]; then
    break
fi
sleep 2
done