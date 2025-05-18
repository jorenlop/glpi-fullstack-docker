#!/bin/bash
echo "🧱 Creando estructura de carpetas en glpi/files/"
cd glpi
mkdir -p files/_cron files/_dumps files/_graphs files/_lock files/_pictures files/_plugins \
         files/_rss files/_sessions files/_tmp files/_uploads
chown -R www-data:www-data files
chmod -R 755 files
