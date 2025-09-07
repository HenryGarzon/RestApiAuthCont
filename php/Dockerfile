FROM php:8.1-fpm-alpine

# Instalar extensiones PHP + Git + cliente MariaDB
RUN apk update && apk add --no-cache \
    git bash mariadb-client \
    && docker-php-ext-install pdo pdo_mysql mysqli

WORKDIR /var/www/html

CMD ["php-fpm"]
