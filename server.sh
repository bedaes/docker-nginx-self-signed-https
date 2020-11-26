#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset

docker run --name self-signed --net host \
           -e REMOTE_URL=http://127.0.0.1:8080 \
           --rm -it $(docker build -q .)
