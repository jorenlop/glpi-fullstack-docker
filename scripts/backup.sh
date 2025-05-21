#!/usr/bin/env bash
set -euo pipefail

# Nombre del contenedor de BD en tu docker-compose
DB_CONTAINER="glpi-db"
DB_NAME="glpi"
DB_USER="glpi"
DB_PASS="glpipass"

# Dónde se guardan los dumps en el host
BACKUP_DIR="$(pwd)/backups/daily/$(date +%F)"
mkdir -p "$BACKUP_DIR"
SQL_FILE="$BACKUP_DIR/glpi.sql"

echo "🌐  Haciendo dump de la base de datos desde ${DB_CONTAINER}..."
docker exec "$DB_CONTAINER" \
  sh -c "exec mysqldump -u${DB_USER} -p'${DB_PASS}' ${DB_NAME} --single-transaction --skip-lock-tables" \
  > "$SQL_FILE"

echo "🔧  Comprimiendo dump..."
gzip -f "$SQL_FILE"

echo "✅  Backup completado en $SQL_FILE.gz"