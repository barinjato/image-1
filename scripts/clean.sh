#!/bin/bash

if [[ "$#" -ne 2 ]];
then
  echo "usage: $0 image-name image-version"
  exit 1
fi

IMAGE_NAME=$1; shift
IMAGE_VERSION=$1; shift
CONTAINER_NAME=${IMAGE_NAME}-${IMAGE_VERSION}-container

echo "*"
echo "* [ ${IMAGE_NAME}:${IMAGE_VERSION} ] cleaning ..."
echo "*"

docker rm -f ${CONTAINER_NAME} | true
