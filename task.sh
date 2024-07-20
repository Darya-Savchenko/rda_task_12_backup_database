#! /bin/bash

mysqldump -u "$DB_USER" -p"$DB_PASSWORD" ShopDB --no-create-db --result-file=backup-ShopDBReserve.sql
mysql -u "$DB_USER" -p"$DB_PASSWORD" ShopDBReserve < backup-ShopDBReserve.sql

mysqldump -u "$DB_USER" -p"$DB_PASSWORD" ShopDB --no-create-db --no-create-info --result-file=backup-ShopDBDevelopment.sql
mysql -u "$DB_USER" -p"$DB_PASSWORD" ShopDBDevelopment < backup-ShopDBDevelopment.sql
