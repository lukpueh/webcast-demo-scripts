#!/bin/bash

set -x
cd $DEMO_PATH
if [ -e workbench ]
then
    rm -rf workbench
fi

mkdir -vp workbench && cd workbench
# Needs -R not -r to preserve relative symbolic links, e.g. in
# `node_module/.bin` otherwise npm run build breaks mysteriously
cp -R ../webapp . && cd webapp

echo "tagging release"
git tag -m tag v1.0 1.0

echo "cloning source-code repository"

echo "building running eslint..."
eslint src/

echo "building react app"
npm run build

echo "dockerizing image"
cp ../../demoscripts/Dockerfile .

docker build -t in-toto-dockerized .
docker run -p 8080:80 -t in-toto-dockerized
