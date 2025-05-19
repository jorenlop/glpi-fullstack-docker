#!/bin/bash
set -e

echo "🧱 Creando estructura glpi/files/ …"
mkdir -p glpi/files/_cron \
         glpi/files/_dumps \
         glpi/files/_graphs \
         glpi/files/_lock \
         glpi/files/_pictures \
         glpi/files/_plugins \
         glpi/files/_rss \
         glpi/files/_sessions \
         glpi/files/_tmp \
         glpi/files/_uploads

echo "⚠️  No intentamos aplicar www-data (solo root en este contenedor)"