#!/bin/bash
set -e

OPENLDAP_HOST="${OPENLDAP_HOST:-openldap}"
OPENLDAP_PORT="${OPENLDAP_PORT:-389}"

sed -i "s/^\/\/ \(\$servers->setValue('server','host','\).*\(');\)$/\1$OPENLDAP_HOST\2/g" /var/www/config/config.php
sed -i "s/^\/\/ \(\$servers->setValue('server','port','\).*\(');\)$/\1$OPENLDAP_PORT\2/g" /var/www/config/config.php

if [ "$1" = '/run.sh' ]; then
	exec /run.sh "$@"
fi

exec "$@"
