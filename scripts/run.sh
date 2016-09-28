#!/bin/bash

SCRIPT_DIR="$(dirname ${0})"

## *
function loadConfigFile() {
  if [[ ! -f ${1} ]]
  then
    echo "ERROR: the config file '${1}' does not exist"
    exit 1
  fi
  source ${1} 2> /dev/null
  # in case there are no keys we do not want to see the output of `export` with no args
  export $(getVariableKeys ${1}) > /dev/null
}

function getVariableKeys() {
  # use grep to exclude comments and empty lines
  # do not print errors
  grep -v -e "^[:space:]*#" -e "^[:space:]*$" ${1} 2> /dev/null | cut -d '=' -f 1
}

## Configuration
loadConfigFile run.cfg

## Main
case ${1} in
  clean)
    ${SCRIPT_DIR}/clean.sh  ${MY_IMAGE_NAME} ${MY_IMAGE_VERSION}
  ;;
  build)
    ${SCRIPT_DIR}/build.sh  ${MY_IMAGE_NAME} ${MY_IMAGE_VERSION}
  ;;
  test)
    ${SCRIPT_DIR}/clean.sh  ${MY_IMAGE_NAME} ${MY_IMAGE_VERSION}
    ${SCRIPT_DIR}/test.sh   ${MY_IMAGE_NAME} ${MY_IMAGE_VERSION} ${MY_IMAGE_TEST}
  ;;
  debug)
    ${SCRIPT_DIR}/clean.sh  ${MY_IMAGE_NAME} ${MY_IMAGE_VERSION}
    ${SCRIPT_DIR}/debug.sh  ${MY_IMAGE_NAME} ${MY_IMAGE_VERSION} ${MY_APP_NAME} ${MY_APP_HOME} ${MY_APP_CONFIG_FILE}
  ;;
  push)
    ${SCRIPT_DIR}/push.sh   ${MY_IMAGE_NAME} ${MY_IMAGE_VERSION}
  ;;
  pull)
    ${SCRIPT_DIR}/pull.sh   ${MY_IMAGE_NAME} ${MY_IMAGE_VERSION}
  ;;
  *)
    echo "Please provide one of the following commands:"
    echo "  clean"
    echo "  build"
    echo "  test"
    echo "  debug"
    echo "  push"
    echo "  pull"
  ;;
esac
