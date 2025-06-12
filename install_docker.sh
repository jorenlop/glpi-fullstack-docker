#!/bin/bash
set -e

# Actualizar e instalar paquetes necesarios
sudo apt update
sudo apt install -y ca-certificates curl gnupg lsb-release

# Agregar la clave GPG oficial de Docker
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | \
  sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

# Agregar repositorio de Docker
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
  https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Instalar Docker Engine y Docker Compose v2
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Habilitar y arrancar el servicio Docker
sudo systemctl enable docker
sudo systemctl start docker

# Agregar el usuario actual al grupo docker (requiere logout/login)
sudo usermod -aG docker "$USER"

echo "✅ Docker y Docker Compose v2 instalados correctamente."
echo "ℹ️ Reinicia sesión o ejecuta 'newgrp docker' para usar Docker sin sudo."
