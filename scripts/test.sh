#!/bin/bash

if [[ "$#" -lt 3 ]];
then
  echo "usage: $0 image-name image-version"
  exit 1
fi

IMAGE_NAME=$1; shift
IMAGE_VERSION=$1; shift
IMAGE_TEST=$*
CONTAINER_NAME=${IMAGE_NAME}-${IMAGE_VERSION}-container

echo "*"
echo "* [ ${IMAGE_NAME}:${IMAGE_VERSION} ] testing ..."
echo "* [ ${IMAGE_NAME}:${IMAGE_VERSION} ] test case: "${IMAGE_TEST}
echo "*"

docker run \
  --tty \
  --name ${CONTAINER_NAME} \
  ${IMAGE_NAME}:${IMAGE_VERSION} \
  ${IMAGE_TEST}
