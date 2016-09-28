#!/bin/bash

if [[ "$#" -lt 4 ]];
then
  echo "usage: $0 image-name image-version app-name app-home"
  exit 1
fi

IMAGE_NAME=$1; shift
IMAGE_VERSION=$1; shift
APP_NAME=$1; shift
APP_HOME=$1; shift
CONFIG_FILE=$1; shift
CONTAINER_NAME=${IMAGE_NAME}-${IMAGE_VERSION}-container

echo "*"
echo "* [ ${IMAGE_NAME}:${IMAGE_VERSION} ] debugging ..."
echo "* [ ${IMAGE_NAME}:${IMAGE_VERSION} ] app name: "${APP_NAME}
echo "* [ ${IMAGE_NAME}:${IMAGE_VERSION} ] app home: "${APP_HOME}
echo "* [ ${IMAGE_NAME}:${IMAGE_VERSION} ] app config file: "${CONFIG_FILE}
echo "*"

docker run \
  --tty \
  --detach \
  --name ${CONTAINER_NAME} \
  --volume ${APP_HOME}:/home/user1/${APP_NAME} \
  --env APP_NAME=${APP_NAME} \
  --env APP_CONFIG_FILE=${CONFIG_FILE} \
  --workdir /home/user1/${APP_NAME} \
  --publish 3550:3550 \
  ${IMAGE_NAME}:${IMAGE_VERSION}

echo "*"
echo "* [ ${IMAGE_NAME}:${IMAGE_VERSION} ] ... started"
echo "* [ ${IMAGE_NAME}:${IMAGE_VERSION} ] invoking a shell into the container ..."
echo "* [ ${IMAGE_NAME}:${IMAGE_VERSION} ] type 'exit' when you are done"
echo "*"

docker exec -it ${CONTAINER_NAME} bash
