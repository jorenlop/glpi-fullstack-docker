# Makefile

init:
	bash scripts/install-glpi.sh
	bash scripts/post-init.sh
	@echo "🔧 Ajustando permisos finales (root):"
	# arrancamos en / para evitar el problema de mount namespace
	docker exec -u root -w / glpi-web chown -R root:root /var/www/html
	@echo "✅ Instalación completada en el contenedor."

up:
	docker compose up -d --build

down:
	docker compose down -v

backup:
	# idem: arrancar en / para que el cron.sh funcione sin errores de cwd
	docker exec -u root -w / glpi-web bash -c "/var/www/html/scripts/backup.sh"

restore:
	bash scripts/restore.sh

restore-prod:
	bash scripts/restore_from_prod.sh