#!/bin/bash
set -e
DATE=$(date +%F)
BACKUP_DIR="/backups/daily/$DATE"
GLPI_FILES="/var/www/html/files"
DB_DUMP="$BACKUP_DIR/glpi.sql"
ARCHIVE="$BACKUP_DIR/glpi-backup-$DATE.tar.gz"
HASHFILE="$ARCHIVE.sha256"
REMOTE="onedrive_glpi:/glpi-backups/$DATE"
mkdir -p "$BACKUP_DIR"
mysqldump -h glpi-db -uglpi -pglpipass glpi > "$DB_DUMP"
tar -czf "$ARCHIVE" -C "$BACKUP_DIR" glpi.sql -C "$GLPI_FILES" .
sha256sum "$ARCHIVE" > "$HASHFILE"
rclone copy "$ARCHIVE" "$REMOTE"
rclone copy "$HASHFILE" "$REMOTE"
