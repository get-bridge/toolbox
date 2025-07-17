#!/bin/bash

set -e

if [ "${1}" = "" ]; then
  exec /bin/bash -l
else
  exec "$@"
fi
