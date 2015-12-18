docker-phpldapadmin
===================

A Docker image running phpLDAPadmin using the Nginx webserver on Debian stable.
It is expected to link to a running OpenLDAP server.

NOTE: Never expose this application directly to the internet as it runs as
insecure HTTP only - on purpose. It is expected that this application resides
behind a reverse proxy of some kind that deals with securing the site.

Usage
-----

Normally the application is started like so:

    docker run -d -p 80:80 --link openldap:openldap dinkel/phpldapadmin

Configuration (environment variables)
-------------------------------------

    OPENLDAP_HOST (defaults to 'openldap')

sets the host of the LDAP server.

    OPENLDAP_PORT (defaults to '389')

sets the port of the LDAP server.

Todo / Restrictions
-------------------

Currently only unencrypted communication between this application and a LDAP
server ist supported, because I don't have access to a TLS and/or SASL secured
server and therefore cannot test it. It should however be quite trivial to
enhance `bootstrap.sh` in an analogous manner to support such scenarios. I would
be happy to se some merge requests or you could send me a note and I will
consider enhancing it.
