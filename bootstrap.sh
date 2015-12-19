#!/bin/bash
set -e

CONFIG_LDAP_SERVER_HOST="${CONFIG_LDAP_SERVER_HOST:-openldap}"
CONFIG_LDAP_SERVER_PORT="${CONFIG_LDAP_SERVER_PORT:-389}"

sed -i "s/^\/\/ \(\$servers->setValue('server','host','\).*\(');\)$/\1$CONFIG_LDAP_SERVER_HOST\2/g" /var/www/config/config.php
sed -i "s/^\/\/ \(\$servers->setValue('server','port',\).*\();\)$/\1$CONFIG_LDAP_SERVER_PORT\2/g" /var/www/config/config.php

if [ "$1" = '/run.sh' ]; then
	exec /run.sh "$@"
fi

exec "$@"
