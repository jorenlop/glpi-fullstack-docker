# Inicializa GLPI local: instala, configura permisos y directorios
init:
	bash scripts/install-glpi.sh
	bash scripts/post-init.sh
	docker exec glpi-web chown -R www-data:www-data /var/www/html
	docker exec glpi-web chmod -R 755 /var/www/html/files

# Levanta los contenedores en segundo plano (modo producción)
up:
	docker compose up -d --build

# Detiene y elimina contenedores y volúmenes
down:
	docker compose down -v

# Ejecuta backup local (BD + archivos)
backup:
	docker exec glpi-web bash /var/www/html/scripts/backup.sh

# Restaura backup local (desde carpeta backups/)
restore:
	bash scripts/restore.sh

# Restaura backup desde entorno productivo remoto o copia
restore-prod:
	bash scripts/restore_from_prod.sh

# Backup en la nube (usando rclone)
backup-cloud:
	docker exec glpi-web bash /var/www/html/scripts/backup_to_cloud.sh

# Backup manual solo de la base de datos
backup-db:
	docker exec glpi-db /usr/bin/mysqldump -uglpi -pglpipass glpi > backups/manual_glpi_db.sql

# Acceso interactivo al contenedor web
shell:
	docker exec -it glpi-web bash

# Ver logs del contenedor web
logs:
	docker logs -f glpi-web