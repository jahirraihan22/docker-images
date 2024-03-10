FROM ubuntu:22.04
LABEL authors="jahir"

WORKDIR /var/www/html

COPY ./app /var/www/html

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y apache2 php libapache2-mod-php

EXPOSE 80

CMD ["apache2ctl", "-D", "FOREGROUND"]