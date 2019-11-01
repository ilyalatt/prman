#!/bin/bash
set -e

./bundle_app.sh
docker build .
IMG=$(docker build -q .) # it uses a cached version
docker run --rm "$IMG" cat /build/prman.snap > prman.snap
docker image rm "$IMG"
