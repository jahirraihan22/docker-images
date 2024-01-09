#!/bin/bash
MYSQL_ROOT_PASSWORD="root"
DB_CONTAINER="my-db"
DB_PORT=3306
MYSQL_IMAGE_VERSION="latest"
NETWORK_NAME="my-container-net"

PHPMYADMIN_VERSION="latest"
PHPMYADMIN_CONTAINER="web-db"
PHPMYADMIN_PORT=81

APP_CONTAINER="mywebapp"

docker rm -f $DB_CONTAINER $PHPMYADMIN_CONTAINER $APP_CONTAINER
sleep 2

#echo -e "Creating Network..\n"
#docker network create $NETWORK_NAME

echo -e "Creating DB Container..\n"
docker run --name $DB_CONTAINER \
  -e MYSQL_ROOT_PASSWORD=$MYSQL_ROOT_PASSWORD \
  --network=$NETWORK_NAME \
  -d -p $DB_PORT:3306 \
  mysql:$MYSQL_IMAGE_VERSION

echo -e "Creating phpmyadmin Container..\n"

docker run --name $PHPMYADMIN_CONTAINER \
  --network=$NETWORK_NAME \
  -e PMA_HOST=$DB_CONTAINER \
  -e PMA_PORT=$DB_PORT \
  -d -p $PHPMYADMIN_PORT:80 \
  phpmyadmin:$PHPMYADMIN_VERSION

docker run --name mywebapp \
  --network=my-container-net \
  -e DB_HOST=$DB_CONTAINER\
  -e DB_USER=root \
  -e DB_PASSWORD=$MYSQL_ROOT_PASSWORD \
  -e DB_NAME=crud \
  -d -p 80:80 \
  jahirraihan/php-apache2:v-php8.1


docker ps -a