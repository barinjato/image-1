#!/bin/bash

if [[ "$#" -ne 2 ]];
then
  echo "usage: $0 image-name image-version"
  exit 1
fi

IMAGE_NAME=$1; shift
IMAGE_VERSION=$1; shift

echo "*"
echo "* [ ${IMAGE_NAME}:${IMAGE_VERSION} ] pulling ..."
echo "*"

docker pull barinjato/my-repo-1/${IMAGE_NAME}:${IMAGE_VERSION}
docker inspect barinjato/my-repo-1/${IMAGE_NAME}:${IMAGE_VERSION}
