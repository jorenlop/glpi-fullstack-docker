# 🚀 GLPI Docker Infraestructura Productiva

![Docker](https://img.shields.io/badge/Docker-GLPI-blue?logo=docker)
![PHP](https://img.shields.io/badge/PHP-8.2-blue?logo=php)
![MariaDB](https://img.shields.io/badge/MariaDB-10.11-blue?logo=mariadb)
![GLPI](https://img.shields.io/badge/GLPI-10.0.18-brightgreen)
![Cron Support](https://img.shields.io/badge/Cron-enabled-yellow)

---

### 📦 Descripción

Repositorio listo para desplegar **GLPI 10.0.18** en contenedores Docker para un entorno **productivo o local de pruebas**, con soporte completo para:

- Apache + PHP 8.2
- Base de datos MariaDB 10.11
- Scripts de instalación y restauración
- Soporte para **backups automáticos diarios**
- Integración con **rclone** para respaldos en la nube
- Soporte completo para `cron.php`

---

### 🧱 Estructura del Proyecto

```
.
├── docker-compose.yml
├── Dockerfile
├── Makefile
├── README.md
├── docker/
│   └── custom-php.ini
├── scripts/
│   ├── install-glpi.sh
│   ├── post-init.sh
│   ├── backup.sh
│   ├── backup_to_cloud.sh
│   ├── restore.sh
│   └── restore_from_prod.sh
├── glpi/                # Código fuente de GLPI
├── volumes/
│   ├── glpi-files/      # Carpeta persistente `files/` de GLPI
│   └── db-data/         # Datos persistentes de la base de datos
└── backups/             # Copias de seguridad automáticas
```

---

### 🔧 Comandos Útiles (Makefile)

```bash
make init             # Instala GLPI desde cero + permisos
make up               # Levanta los servicios
make down             # Detiene y elimina contenedores + volúmenes
make backup           # Ejecuta backup local
make restore          # Restaura backup local
make restore-prod     # Restaura backup desde ambiente productivo
```

---

### 📅 Tareas Automáticas (Cron)

El contenedor de Apache ejecuta el cron de GLPI cada minuto mediante un proceso interno en `supervisord`.

Adicionalmente, se genera un backup diario a las 2:00 AM:

```crontab
0 2 * * * bash /var/www/html/scripts/backup_to_cloud.sh >> /var/www/html/scripts/backup.log 2>&1
```

---

### ☁️ Soporte para Rclone

Este entorno está preparado para sincronizar automáticamente tus backups con la nube mediante [rclone](https://rclone.org/). Solo necesitas:

- Configurar tu `~/.config/rclone` en tu máquina host.
- Definir tu `remote:` en el script `backup_to_cloud.sh`.

---

### 🧪 Requisitos

- Docker y Docker Compose instalados
- Usuario con permisos para montar volúmenes y acceder al sistema de archivos

---

### 📅 Última actualización

**May 18, 2025**

---

Desarrollado y mantenido por Jorge Enrique Lopez.
