[![build](https://github.com/fab-infra/docker-php-apache/actions/workflows/build.yml/badge.svg)](https://github.com/fab-infra/docker-php-apache/actions/workflows/build.yml)

# PHP + Apache HTTPD Docker image

## Ports

The following ports are exposed by this container image.

| Port | Description |
| ---- | ----------- |
| 8080 | HTTP port |
| 8443 | HTTPS port |

## Environment variables

The following environment variables can be used with this container.

| Variable | Description | Default value |
| -------- | ----------- | ------------- |
| SERVER_NAME | Server host name | $(hostname -f) |
| SERVER_ENV | Server environment | production |
| DEFAULT_DOCROOT | Document root of the default virtual host | /srv/www/htdocs |
| LISTEN_HTTP_PORT | HTTP port to listen to | 8080 |
| LISTEN_HTTPS_PORT | HTTPS port to listen to | 8443 |

## Volumes

The following container paths can be used to mount a dedicated volume or to customize configuration.

| Path | Description |
| ---- | ----------- |
| /etc/apache2/vhosts.d | Virtual hosts configuration (*.conf files) |
| /etc/php7/apache2/php.ini | PHP configuration |
| /srv/www/htdocs | Default document root |
| /var/lib/php7 | Session save path |
| /var/log/apache2 | Access and error logs |

## Useful links

- [Apache HTTPD documentation](https://httpd.apache.org/docs/2.4/)
- [PHP documentation](https://www.php.net/manual/en/)
