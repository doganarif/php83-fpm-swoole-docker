# syntax=docker/dockerfile:1

# PHP 8.3 FPM Base Image with OpenSwoole
# Maintainer: Arif <me@arif.sh>
# Repository: https://github.com/doganarif/php83-fpm-swoole-docker

FROM php:8.3-fpm-alpine

LABEL maintainer="Arif <me@arif.sh>" \
    org.opencontainers.image.authors="Arif <me@arif.sh>" \
    org.opencontainers.image.title="PHP 8.3 FPM OpenSwoole Base Image" \
    org.opencontainers.image.description="Production-ready PHP 8.3 FPM Alpine base image with OpenSwoole for high-performance PHP applications" \
    org.opencontainers.image.source="https://github.com/doganarif/php83-fpm-swoole-docker" \
    org.opencontainers.image.vendor="doganarif" \
    org.opencontainers.image.licenses="MIT"

# Install system dependencies and PHP extensions
RUN set -eux; \
    apk add --no-cache \
    bash \
    git \
    curl \
    libzip-dev \
    openssl \
    unzip; \
    \
    apk add --no-cache --virtual .build-deps $PHPIZE_DEPS; \
    \
    docker-php-ext-install \
    bcmath \
    pcntl \
    pdo \
    pdo_mysql \
    zip; \
    \
    pecl install openswoole; \
    docker-php-ext-enable openswoole; \
    \
    # Cleanup
    apk del --no-cache .build-deps

# Copy Composer from the official Composer image
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer
