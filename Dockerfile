
FROM php:8.1-fpm

# Set working directory
WORKDIR /var/www

# Install dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    libpng-dev \
    libjpeg62-turbo-dev \
    libfreetype6-dev \
    locales \
    zip \
    jpegoptim optipng pngquant gifsicle \
    vim \
    unzip \
    git \
    curl

# Clear cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

RUN docker-php-ext-install mysqli pdo pdo_mysql && docker-php-ext-enable pdo_mysql

RUN apt-get --yes install libfreetype6-dev \
                          libjpeg62-turbo-dev \
                          libpng-dev 

RUN set -e; \
    docker-php-ext-configure gd --with-jpeg  --with-freetype; \
    docker-php-ext-install -j$(nproc) gd

# Copy existing application directory contents
COPY public /var/www


# Expose port 9000 and start php-fpm server
EXPOSE 9000
CMD ["php-fpm"]