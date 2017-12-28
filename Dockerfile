FROM ubuntu:latest
MAINTAINER Riouallon Vincent

RUN apt-get update && apt-get install -y \
  nginx php7.0-fpm php7.0-cli php7.0-common php7.0-curl php7.0-gd php7.0-intl php7.0-json php7.0-mbstring php7.0-mcrypt php7.0-mysql php7.0-opcache php7.0-pgsql php7.0-soap php7.0-sqlite3 php7.0-xml php7.0-xmlrpc php7.0-xsl php7.0-zip supervisor \
  wget unzip patch

RUN service php7.0-fpm start

# download latest release
RUN wget http:`(wget https://larsjung.de/h5ai/ -q -O -) | sed 's/.*href="\(.*\.zip\)".*/\1/p' | head -n1`
RUN unzip h5ai-*.zip -d /usr/share/h5ai

# add h5ai as the only nginx site
ADD h5ai.nginx.conf /etc/nginx/sites-available/default

# patch h5ai because we want to deploy it ouside of the document root and use /var/www as root for browsing
ADD h5ai-path.patch patch
RUN patch -p1 -u -d /usr/share/h5ai/_h5ai/private/php/core/ -i /patch && rm patch

# use supervisor to monitor all services
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf
CMD supervisord -c /etc/supervisor/conf.d/supervisord.conf

# expose only nginx HTTP port
EXPOSE 80

# expose path
VOLUME /var/www
