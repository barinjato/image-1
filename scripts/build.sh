#!/bin/bash

if [[ "$#" -ne 2 ]];
then
  echo "usage: $0 image-name image-version"
  exit 1
fi

IMAGE_NAME=$1; shift
IMAGE_VERSION=$1; shift

echo "*"
echo "* [ ${IMAGE_NAME}:${IMAGE_VERSION} ] building ..."
echo "*"

docker build \
  --tag ${IMAGE_NAME}:${IMAGE_VERSION} \
  --force-rm \
  ${PWD}
