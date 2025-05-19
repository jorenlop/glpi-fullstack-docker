#!/bin/bash
GLPI_VERSION="10.0.18"
GLPI_URL="https://github.com/glpi-project/glpi/releases/download/${GLPI_VERSION}/glpi-${GLPI_VERSION}.tgz"

if [ -d "glpi" ]; then
  echo "⚠️  El directorio 'glpi' ya existe. ¿Deseas eliminarlo? (s/n)"
  read confirm
  if [ "$confirm" != "s" ]; then
    echo "Cancelado."
    exit 1
  fi
  rm -rf glpi
fi

echo "⬇️  Descargando GLPI versión ${GLPI_VERSION} desde GitHub..."
wget -O glpi.zip "$GLPI_URL"

echo "✅  GLPI ${GLPI_VERSION} instalado correctamente en glpi"
mkdir -p glpi
tar -xzf glpi.zip -C glpi --strip-components=1
