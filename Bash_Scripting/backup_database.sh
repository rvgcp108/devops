#!/bin/bash

# Define MySQL database connection parameters
DB_HOST="localhost"
DB_PORT="3306"
DB_USER="root"
DB_PASSWORD="password"
DB_NAME="mydatabase"

# Define backup file name and path
BACKUP_DIR="/var/backups/mysql"
BACKUP_FILE="$DB_NAME-backup-$(date +%Y-%m-%d-%H-%M-%S).sql.gz"
BACKUP_PATH="$BACKUP_DIR/$BACKUP_FILE"

# Create backup directory if it doesn't exist
if [ ! -d "$BACKUP_DIR" ]
then
    mkdir -p "$BACKUP_DIR"
fi

# Use mysqldump to create a backup of the database and compress it
mysqldump --host="$DB_HOST" --port="$DB_PORT" --user="$DB_USER" --password="$DB_PASSWORD" "$DB_NAME" | gzip > "$BACKUP_PATH"

# Verify that the backup file was created successfully
if [ -f "$BACKUP_PATH" ]
then
    echo "Database backup created successfully: $BACKUP_PATH"
else
    echo "Error creating database backup"
fi
