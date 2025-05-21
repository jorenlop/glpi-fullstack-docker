#!/usr/bin/env bash
set -euo pipefail

# --- Ajusta estos valores según tu entorno ---
CONTAINER_DB="glpi-db"
DB_NAME="glpi"
DB_USER="glpi"
DB_PASS="glpipass"
REMOTE="rmbc:"

# --- Paths ---
ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
DATE="$(date +%F)"
BACKUP_DIR="$ROOT_DIR/backups/daily/$DATE"
DB_DUMP="$BACKUP_DIR/glpi.sql"
ARCHIVE="$BACKUP_DIR/glpi-files-db-$DATE.tar.gz"
HASHFILE="$ARCHIVE.sha256"
GLPI_FILES="$ROOT_DIR/volumes/glpi-files"

# --- Prep dir ---
mkdir -p "$BACKUP_DIR"

# --- Dump de la BD (desde el contenedor) ---
echo "📝 Dumping DB ($DB_NAME) into $DB_DUMP…"
docker exec "$CONTAINER_DB" \
  mysqldump -u"$DB_USER" -p"$DB_PASS" "$DB_NAME" \
  > "$DB_DUMP"

# --- Empaquetar SQL + archivos ---
echo "📦 Creating archive $ARCHIVE…"
tar -czf "$ARCHIVE" \
  -C "$BACKUP_DIR" "$(basename "$DB_DUMP")" \
  -C "$GLPI_FILES" .

# --- Suma de comprobación ---
echo "🔢 Generating SHA256 checksum…"
sha256sum "$ARCHIVE" > "$HASHFILE"

# --- Subida con rclone ---
echo "⬆️  Uploading to remote $REMOTE/$DATE/ …"
rclone mkdir "$REMOTE/$DATE"
rclone copy "$ARCHIVE"     "$REMOTE/$DATE"
rclone copy "$HASHFILE"    "$REMOTE/$DATE"

echo "✅ Backup and upload completed."