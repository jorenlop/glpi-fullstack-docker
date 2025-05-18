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
