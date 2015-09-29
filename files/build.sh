#!/usr/bin/env bash

set -ex
source /home/omnibus/load-omnibus-toolchain.sh
cd /home/omnibus/omnibus-project
bundle install --binstubs bundle_bin --without development test
./bundle_bin/omnibus build ${OMNIBUS_PROJECT}
