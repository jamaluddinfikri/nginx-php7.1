# Nginx-php71
isi service image ini :
- nginx
- php 7.1
- supervisor
- composer php

imagas ini di kususkan untuk `aksara` / `laravel` dan untuk contoh pengunaan sebagai berikut : <br>

Example :
- **Ini tanpa bind volume webroot**
```
docker run -d -p 80:80 -p 443:443 --name aksara jamal008/aksara
```

- **menambahakan bind volume ke webroot**
```
docker run -d -p 80:80 -p 443:443 -v (folder webroot):/var/www/html --name aksara jamal008/aksara
```
refrensi : ` -v /home/xxx/sapi/webroot:/var/www/html`
- **menambahan bind volume ke webroot dan nginx config**
```
docker run -d -p 80:80 -p 443:443 -v (folder webroot):/var/www/html -v (folder nginx config):/etc/nginx/sites-enabled --name aksara jamal008/aksara
```
refrensi : `-v /home/xxx/nginx:/var/www/html` <br>
refrensi : ` -v /home/xxx/sapi/webroot:/var/www/html`

NB : untuk link repo full config ada di [link ini](https://gitlab.com/jamaluddin8157/nginx-php7.1)