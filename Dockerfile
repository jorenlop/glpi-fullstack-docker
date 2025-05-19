FROM php:8.2-apache

ENV TZ=America/Bogota
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
  cron nano wget unzip zip git supervisor \
  libpng-dev libjpeg-dev libfreetype6-dev \
  libonig-dev libxml2-dev libzip-dev libicu-dev \
  libsodium-dev libbz2-dev locales tzdata \
  && docker-php-ext-configure gd --with-freetype --with-jpeg \
  && docker-php-ext-install -j$(nproc) \
  pdo pdo_mysql mysqli gd mbstring zip intl xml opcache bz2 \
  && apt-get clean && rm -rf /var/lib/apt/lists/*


# Configurar zona horaria
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Activar mod_rewrite
RUN a2enmod rewrite

# Copiar configuración personalizada
COPY docker/custom-php.ini /usr/local/etc/php/conf.d/custom.ini

# Copiar archivo de cron
COPY docker/crontab /etc/cron.d/glpi-cron
RUN chmod 0644 /etc/cron.d/glpi-cron && crontab /etc/cron.d/glpi-cron

# Crear carpeta de logs del cron
RUN mkdir -p /var/log/cron

# Copiar configuración de supervisord
COPY docker/supervisord.conf /etc/supervisord.conf

# Crear carpeta base del proyecto
WORKDIR /var/www/html

# Copiar script de arranque personalizado
COPY docker/start.sh /start.sh
RUN chmod +x /start.sh

# Exponer el puerto de Apache
EXPOSE 80

# Ejecutar Apache y cron desde script personalizado
CMD ["/start.sh"]