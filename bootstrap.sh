#!/bin/bash
set -e

if [ ! -f "/var/www/config/config.php" ]; then
    cp /var/www/default_config/config.php.example /var/www/config/config.php
fi

sed -i "s/^\/\/ \(\$servers->setValue('server','host','\).*\(');\)$/\1openldap\2/g" /var/www/config/config.php

if [ "$1" = '/run.sh' ]; then
	exec /run.sh "$@"
fi

exec "$@"
