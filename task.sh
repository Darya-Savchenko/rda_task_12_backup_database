#!/bin/bash

# Check for the presence of arguments
if [ $# -ne 2 ]; then
  echo "Usage: $0 <DB_USER> <DB_PASSWORD>"
  exit 1
fi

DB_USER=$1
DB_PASSWORD=$2

# Dump the ShopDB database
mysqldump -u "$DB_USER" -p"$DB_PASSWORD" ShopDB --no-create-db --result-file=backup-ShopDBReserve.sql
if [ $? -ne 0 ]; then
  echo "Error creating the dump of the ShopDB database"
  exit 1
fi

# Restore the ShopDBReserve database
mysql -u "$DB_USER" -p"$DB_PASSWORD" ShopDBReserve < backup-ShopDBReserve.sql
if [ $? -ne 0 ]; then
  echo "Error restoring the ShopDBReserve database"
  exit 1
fi

# Dump the ShopDB database without table structure
mysqldump -u "$DB_USER" -p"$DB_PASSWORD" ShopDB --no-create-db --no-create-info --result-file=backup-ShopDBDevelopment.sql
if [ $? -ne 0 ]; then
  echo "Error creating the dump of the ShopDB database without table structure"
  exit 1
fi

# Restore the ShopDBDevelopment database
mysql -u "$DB_USER" -p"$DB_PASSWORD" ShopDBDevelopment < backup-ShopDBDevelopment.sql
if [ $? -ne 0 ]; then
  echo "Error restoring the ShopDBDevelopment database"
  exit 1
fi

echo "Database successfully backed up and restored"
