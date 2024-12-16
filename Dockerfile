FROM php:8.3-fpm

# Mise à jour du cache et installation des dépendances système
RUN apt-get clean && apt-get update && apt-get install -y \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libicu-dev \
    libpq-dev \
    zip \
    unzip \
    curl \
    libonig-dev \
    libzip-dev \
    libxslt1-dev \
    && apt-get clean

# Configuration et installation des extensions PHP
RUN docker-php-ext-configure gd --with-freetype --with-jpeg && \
    docker-php-ext-install \
    pdo_pgsql \
    pgsql \
    mysqli \
    pdo_mysql \
    zip \
    bcmath \
    intl \
    pcntl \
    sockets \
    xsl \
    gd

# Vérification de l'installation de pdo_pgsql (ajouter cette ligne)
RUN php -m | grep pdo_pgsql || echo "pdo_pgsql not installed"

# Installer Git (si ce n'est pas inclus dans l'image par défaut)
RUN apt-get update && apt-get install -y git && apt-get clean

# Installer Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Définir le répertoire de travail dans le conteneur
WORKDIR /var/www/html

# Copier les fichiers du projet Laravel (y compris composer.json) dans le conteneur
COPY ./laravel-app/ /var/www/html/

# Copie le fichier php.ini personnalisé dans le conteneur
COPY ./docker/php/php.ini /usr/local/etc/php/conf.d/

# Exposer le port pour PHP-FPM
EXPOSE 9000
