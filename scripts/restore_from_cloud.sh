#!/bin/bash
set -e
REMOTE="onedrive_glpi:/glpi-backups"
LATEST_DATE=$(rclone lsf "$REMOTE" | sort | tail -n 1 | tr -d '/')
if [ -z "$LATEST_DATE" ]; then
  echo "❌ No se encontró ningún backup en la nube."
  exit 1
fi
LOCAL_DIR="backups/latest"
REMOTE_ARCHIVE="$REMOTE/$LATEST_DATE/glpi-backup-$LATEST_DATE.tar.gz"
REMOTE_HASH="$REMOTE/$LATEST_DATE/glpi-backup-$LATEST_DATE.tar.gz.sha256"
ARCHIVE_PATH="$LOCAL_DIR/glpi-backup-$LATEST_DATE.tar.gz"
HASHFILE_PATH="$LOCAL_DIR/glpi-backup-$LATEST_DATE.tar.gz.sha256"
mkdir -p "$LOCAL_DIR"
rclone copy "$REMOTE/$LATEST_DATE/" "$LOCAL_DIR" --include "glpi-backup-$LATEST_DATE.tar.gz"
rclone copy "$REMOTE/$LATEST_DATE/" "$LOCAL_DIR" --include "glpi-backup-$LATEST_DATE.tar.gz.sha256"
cd "$LOCAL_DIR"
sha256sum -c "$(basename $HASHFILE_PATH)"
cd -
tar -xzf "$ARCHIVE_PATH" -C "$LOCAL_DIR"
bash scripts/restore.sh
