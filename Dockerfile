FROM dinkel/nginx-phpfpm:8.1

MAINTAINER Christian Luginbühl <dinke@pimprecords.com>

ENV PHPLDAPADMIN_VERSION 1.2.3

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y \
        curl \
        ldap-utils \
        php5-ldap && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN curl -L http://sourceforge.net/projects/phpldapadmin/files/phpldapadmin-php5/$PHPLDAPADMIN_VERSION/phpldapadmin-$PHPLDAPADMIN_VERSION.tgz/download | tar zx -C /var/ && \
    mv /var/phpldapadmin-$PHPLDAPADMIN_VERSION/ /var/www/

RUN chown -R root:root /var/www/

RUN cp -R /var/www/config /var/www/default_config

# Since PHP 5.5 there is a new internal 'password_hash' function
RUN find /var/www/ -name "*.php" | xargs sed -i "s/password_hash/pla_password_hash/g"

COPY default.conf /etc/nginx/conf.d/

COPY www.conf /etc/php5/fpm/pool.d/

COPY bootstrap.sh /

ENTRYPOINT ["/bootstrap.sh"]

VOLUME ["/var/www/config"]

# This script comes from the parent image
CMD ["/run.sh"]
