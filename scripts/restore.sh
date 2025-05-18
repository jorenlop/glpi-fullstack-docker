#!/bin/bash
set -e
BACKUP_DIR="/backups/latest"
DB_FILE="$BACKUP_DIR/glpi.sql"
FILES_DIR="$BACKUP_DIR/files"
if [ ! -f "$DB_FILE" ]; then
  echo "❌ Archivo de base de datos no encontrado: $DB_FILE"
  exit 1
fi
if [ ! -d "$FILES_DIR" ]; then
  echo "❌ Directorio de archivos no encontrado: $FILES_DIR"
  exit 1
fi
cat "$DB_FILE" | docker exec -i glpi-db sh -c 'mysql -uglpi -pglpipass glpi'
docker cp "$FILES_DIR" glpi-web:/var/www/html/files
echo "✅ Restauración completa."
