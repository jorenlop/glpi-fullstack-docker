#!/bin/bash
GLPI_VERSION=10.0.18
if [ -d "glpi" ]; then
  echo "⚠️ El directorio 'glpi' ya existe. ¿Deseas eliminarlo? (s/n)"
  read CONFIRM
  if [ "$CONFIRM" != "s" ]; then
    echo "Cancelado."
    exit 1
  fi
  rm -rf glpi
fi

echo "⬇️ Descargando GLPI versión $GLPI_VERSION desde GitHub..."
wget -O glpi.zip https://github.com/glpi-project/glpi/releases/download/${GLPI_VERSION}/glpi-${GLPI_VERSION}.tgz
mkdir glpi
tar -xzf glpi.zip -C glpi --strip-components=1
echo "✅ GLPI $GLPI_VERSION instalado correctamente en glpi"
