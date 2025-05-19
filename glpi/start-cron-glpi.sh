#!/bin/bash

echo "⏰ Iniciando ejecución automática de GLPI cada minuto..."

while true; do
  echo "🚀 Ejecutando tareas automáticas: $(date '+%Y-%m-%d %H:%M:%S')"
  php /var/www/html/front/cron.php --force --debug
  sleep 60
done
