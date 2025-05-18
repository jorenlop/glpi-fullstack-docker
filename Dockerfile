FROM php:8.2-apache

# Variables de entorno
ENV TZ=America/Bogota
ENV DEBIAN_FRONTEND=noninteractive

# Instalar herramientas necesarias y extensiones PHP
RUN apt-get update && apt-get install -y \
  cron \
  nano \
  wget \
  unzip \
  zip \
  git \
  supervisor \
  libpng-dev \
  libjpeg-dev \
  libfreetype6-dev \
  libonig-dev \
  libxml2-dev \
  libzip-dev \
  libicu-dev \
  libsodium-dev \
  locales \
  tzdata \
  && docker-php-ext-configure gd --with-freetype --with-jpeg \
  && docker-php-ext-install -j$(nproc) pdo pdo_mysql mysqli gd mbstring zip intl xml opcache \
  && apt-get clean && rm -rf /var/lib/apt/lists/*

# Configurar zona horaria
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Activar mod_rewrite de Apache
RUN a2enmod rewrite

# Copiar configuración personalizada de PHP
COPY docker/custom-php.ini /usr/local/etc/php/conf.d/custom.ini

# Copiar archivo de cron y registrar en el sistema
COPY docker/crontab /etc/cron.d/glpi-cron
RUN chmod 0644 /etc/cron.d/glpi-cron && crontab /etc/cron.d/glpi-cron

# Crear carpeta de logs del cron si no existe
RUN mkdir -p /var/log/cron

# Copiar configuración de supervisord
COPY docker/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Crear carpeta base del proyecto
WORKDIR /var/www/html

# Exponer el puerto de Apache
EXPOSE 80

# Iniciar Apache + cron con supervisord
CMD ["/usr/bin/supervisord"]