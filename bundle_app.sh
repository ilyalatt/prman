#!/bin/bash
set -e

rm -rf bundle
mkdir bundle

mkdir -p bundle/src
cp -r src/. bundle/src

cp Pipfile bundle
cp Pipfile.lock bundle

cp init.sh bundle
cp run.sh bundle
