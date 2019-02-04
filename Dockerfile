FROM ubuntu:16.04 

MAINTAINER jamaluddin fikri <mangsasip@gmail.com>

RUN apt-get update -y \
&& apt-get install software-properties-common wget supervisor language-pack-en -y \
&& update-locale LANG=en_US.UTF-8 \
&& wget https://raw.githubusercontent.com/VirtuBox/nginx-ee/master/nginx-build.sh && bash nginx-build.sh --stable \
&& mkdir -p /etc/nginx/sites-enabled

RUN apt install -y apt-utils && export LANG=C.UTF-8 \
&& add-apt-repository -y ppa:ondrej/php \
&& apt-get update && apt install php7.1-fpm php7.1-cli php7.1-zip php7.1-opcache php7.1-mysql php7.1-mcrypt php7.1-mbstring php7.1-json php7.1-intl \
php7.1-gd php7.1-curl php7.1-bz2 php7.1-xml php7.1-tidy php7.1-soap php7.1-bcmath -y

RUN wget -O /etc/php/7.1/fpm/pool.d/www.conf https://raw.githubusercontent.com/VirtuBox/ubuntu-nginx-web-server/master/etc/php/7.1/fpm/pool.d/www.conf

RUN  apt-get clean && rm -rf /usr/local/src/*
#apt install -y curl \
#&& curl -o /tmp/composer-setup.php https://getcomposer.org/installer \
#&& curl -o /tmp/composer-setup.sig https://composer.github.io/installer.sig \
#&& php -r "if (hash('SHA384', file_get_contents('/tmp/composer-setup.php')) !== trim(file_get_contents('/tmp/composer-setup.sig'))) { unlink('/tmp/composer-setup.php'); echo 'Invalid installer' . PHP_EOL; exit(1); }" \
#&& php /tmp/composer-setup.php --no-ansi --install-dir=/usr/local/bin --filename=composer --version=${COMPOSER_VERSION} && rm -rf /tmp/composer-setup.php \



COPY ./conf/common/* /etc/nginx/common/
ADD ./conf/default /etc/nginx/sites-enabled/
ADD ./conf/php/php.ini /etc/php/7.1/fpm/
ADD ./index.php /var/www/html/
ADD ./conf/supervisord.conf /etc/supervisord.conf
ADD ./start.sh /start.sh

RUN chmod +x /start.sh

EXPOSE 80 443
CMD ["/start-new.sh"]