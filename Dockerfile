FROM wordpress:php8.4

RUN apt-get update && \
    apt-get install -y zlib1g-dev libmemcached-dev && \
    pecl channel-update pecl.php.net && \
    pecl install memcache-8.0 && \
    docker-php-source delete && \
    rm -r /tmp/* /var/cache/*

COPY php.ini $PHP_INI_DIR/conf.d/increase_uploads.ini

LABEL org.opencontainers.image.source=https://github.com/CabotScouts/wordpress-memcached

