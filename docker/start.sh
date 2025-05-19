#!/bin/bash
set -e

echo "🔧 Ajustando permisos (root)…"
# aquí no usamos www-data
chown -R root:root /var/www/html

echo "🕒 Arrancando cron"
cron

echo "🚀 Arrancando Apache"
exec apache2-foreground