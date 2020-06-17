FROM debian:buster
MAINTAINER José Domingo Muñoz "josedom24@gmail.com"

ARG MOODLE_VERSION=moodle-latest-38.zip
ARG URL_MOD_JISI=https://moodle.org/plugins/download.php/21488/mod_jitsi_moodle38_2020050700.zip 
ARG MOD_JITSI=mod_jitsi_moodle38_2020050700.zip
#ARG URL_THEME=https://moodle.org/plugins/download.php/21501/theme_moove_moodle38_2020050700.zip
#ARG THEME=theme_moove_moodle38_2020050700.zip
RUN apt-get update \
    && apt-get install -y \
    apache2  libapache2-mod-php7.3 php7.3-mysql php7.3-gd php7.3-curl php7.3-xmlrpc\ 
    php7.3-intl php7.3-zip php7.3-mbstring php7.3-xml php7.3-soap ghostscript unzip wget\
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /var/www/
RUN wget https://download.moodle.org/download.php/direct/stable38/${MOODLE_VERSION} \
    && unzip ${MOODLE_VERSION} \
    && rm ${MOODLE_VERSION} \
    && rm -rf html \
    && mv moodle html \
    && chown -R www-data: html \
    && mkdir moodledata \
    && chown -R www-data: moodledata 

WORKDIR /var/www/html/mod
RUN wget ${URL_MOD_JISI} \
    && unzip ${MOD_JITSI} \
    && rm ${MOD_JITSI} \
    && chown -R www-data: jitsi 
#
#WORKDIR /var/www/html/theme
#RUN wget ${URL_THEME} \
#    && unzip ${THEME} \
#    && rm ${THEME} \
#    && chown -R www-data: moove 


COPY cron /opt/moodle/cron
COPY run.sh /usr/local/bin/run.sh
RUN chmod +x /usr/local/bin/run.sh
COPY config.php /var/www/html/config.php

ENTRYPOINT ["/usr/local/bin/run.sh"]

