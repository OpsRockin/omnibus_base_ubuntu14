#!/usr/bin/env bash

set -ex
source /home/omnibus/load-omnibus-toolchain.sh
cd /home/omnibus/omnibus-project
bundle install --binstubs bundle_bin --without development test

if ! [ "$BUILD_CACHE_PATH" == "" ] ; then
  if [ -d ${BUILD_CACHE_PATH} ] ; then
    git clone ${BUILD_CACHE_PATH} /opt/${OMNIBUS_PROJECT}
  fi
fi

./bundle_bin/omnibus build ${OMNIBUS_PROJECT}
