FROM php:7.2-fpm
MAINTAINER kevin0217 "kevin0217@126.com"

# 设置时区
ENV TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# 安装git和PHP扩展
RUN apt-get update && apt-get install -y \
        git \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng-dev \
	&& docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
	&& docker-php-ext-install -j$(nproc) gd \
        && docker-php-ext-install zip \
        && docker-php-ext-install pdo_mysql \
        && docker-php-ext-install opcache \
        && docker-php-ext-install mysqli \
        && rm -r /var/lib/apt/lists/*

# 复制下载好的文件到容器
COPY ./pkg/redis.tgz /home/redis.tgz
COPY ./pkg/cphalcon.tar.gz /home/cphalcon.tar.gz

# 安装Redis扩展
RUN pecl install /home/redis.tgz && echo "extension=redis.so" > /usr/local/etc/php/conf.d/redis.ini

# 安装Phalcon扩展
RUN cd /home \
    && tar -zxvf cphalcon.tar.gz \
    && mv cphalcon-* phalcon \
    && cd phalcon/build \
    && ./install \
    && echo "extension=phalcon.so" > /usr/local/etc/php/conf.d/phalcon.ini

# 安装Composer，设置环境变量
ENV COMPOSER_HOME /root/composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
ENV PATH $COMPOSER_HOME/vendor/bin:$PATH

RUN rm -f /home/redis.tgz \
        rm -f /home/cphalcon.tar.gz 

WORKDIR /data

# Write Permission
RUN usermod -u 1000 www-data
