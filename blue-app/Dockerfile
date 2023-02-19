FROM ubuntu:latest
LABEL "Author"="JAHIR"
LABEL "PROJECT"="APP BLUE"
ENV DEBIAN_FRONTEND=noninteractive
RUN apt update && apt install apache2 -y
CMD ["/usr/sbin/apache2ctl","-D","FOREGROUND"]
WORKDIR /var/www/html
VOLUME [ "/var/log/apache2" ]
ADD index.html /var/www/html
EXPOSE 80
