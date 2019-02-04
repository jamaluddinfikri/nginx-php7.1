FROM ubuntu:16.04 

MAINTAINER jamaluddin fikri <mangsasip@gmail.com>

# install nginx dan compaile nginx
RUN apt-get update -y \
&& apt-get install software-properties-common wget supervisor language-pack-en -y \
&& update-locale LANG=en_US.UTF-8 \
&& wget https://raw.githubusercontent.com/VirtuBox/nginx-ee/master/nginx-build.sh && bash nginx-build.sh --stable \
&& mkdir -p /etc/nginx/sites-enabled

# install php 7.1
RUN apt install -y apt-utils && export LANG=C.UTF-8 \
&& add-apt-repository -y ppa:ondrej/php \
&& apt-get update && apt install php7.1-fpm php7.1-cli php7.1-zip php7.1-opcache php7.1-mysql php7.1-mcrypt php7.1-mbstring php7.1-json php7.1-intl \
php7.1-gd php7.1-curl php7.1-bz2 php7.1-xml php7.1-tidy php7.1-soap php7.1-bcmath -y

# menambahakan config php www.conf
RUN wget -O /etc/php/7.1/fpm/pool.d/www.conf https://raw.githubusercontent.com/VirtuBox/ubuntu-nginx-web-server/master/etc/php/7.1/fpm/pool.d/www.conf

# install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
&& apt-get clean && rm -rf /usr/local/src/*


# copy config
COPY ./conf/common/* /etc/nginx/common/
ADD ./conf/default /etc/nginx/sites-enabled/
ADD ./conf/php/php.ini /etc/php/7.1/fpm/
ADD ./index.php /var/www/html/
ADD ./conf/supervisord.conf /etc/supervisord.conf
ADD ./start.sh /start.sh

RUN chmod +x /start.sh

EXPOSE 80 443
CMD ["/start.sh"]