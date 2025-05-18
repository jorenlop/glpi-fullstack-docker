#!/bin/bash
echo "⏰ Zona horaria: $TZ"
echo "🚀 Iniciando supervisord..."
exec supervisord -c /etc/supervisord.conf
