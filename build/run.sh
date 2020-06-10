#!/bin/bash

# Changing congiguration's parameters

sed -i "s/$CFG->dbhost    = '';/$CFG->dbhost    = '${MOODLE_DBHOST}';/g" /var/www/html/config.php
sed -i "s/$CFG->dbname    = '';/$CFG->dbname    = '${MOODLE_DBNAME}';/g" /var/www/html/config.php
sed -i "s/$CFG->dbuser    = '';/$CFG->dbuser    = '${MOODLE_DBUSER}';/g" /var/www/html/config.php
sed -i "s/$CFG->dbpass    = '';/$CFG->dbpass    = '${MOODLE_DBPASS}';/g" /var/www/html/config.php
sed -i "s|$CFG->wwwroot   = '';|$CFG->wwwroot   = '${MOODLE_WWWROOT}';|g" /var/www/html/config.php

sed -i "s/post_max_size = 8M/post_max_size = 256M/g" /etc/php/7.3/apache2/php.ini
sed -i "s/upload_max_filesize = 2M/upload_max_filesize = 256M/g" /etc/php/7.3/apache2/php.ini


# Adding cron entries
ln -fs /opt/moodle/cron /etc/cron.d/moodle

/usr/sbin/cron
echo "Starting Apache..."
exec apache2ctl -D FOREGROUND


