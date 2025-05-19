#!/bin/bash

set -e

ROOT_DIR="glpi-prod"

mkdir -p $ROOT_DIR/{glpi,volumes/glpi-files,volumes/db-data,backups/daily,docker,scripts}

# .gitignore
cat > $ROOT_DIR/.gitignore << 'EOF'
/backups/
/volumes/
.env
*.log
*.tar.gz
*.sha256
EOF

# README.md
cat > $ROOT_DIR/README.md << 'EOF'
# GLPI Productivo con Backups y Restauración Automática en la Nube

Este repositorio proporciona una infraestructura lista para producción de GLPI utilizando Docker.
EOF

# Makefile
cat > $ROOT_DIR/Makefile << 'EOF'
init:
	bash scripts/install-glpi.sh
	bash scripts/post-init.sh
	docker exec glpi-web chown -R www-data:www-data /var/www/html

up:
	docker compose up -d --build

down:
	docker compose down -v

backup:
	docker exec glpi-web bash /var/www/html/scripts/backup.sh

restore:
	bash scripts/restore.sh

restore-prod:
	bash scripts/restore_from_prod.sh
EOF

chmod +x $ROOT_DIR/scripts/*.sh || true
chmod +x $ROOT_DIR/docker/start.sh || true
chmod +x $ROOT_DIR/post-init.sh || true

echo "✅ Estructura GLPI creada en: $ROOT_DIR"
