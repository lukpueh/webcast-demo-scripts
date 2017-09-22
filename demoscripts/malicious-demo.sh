#!/usr/bin/bash

set -x
cd /home/santiago/Documents/p2017/in-toto-general/docker-demo/
if [ -e workbench ]
then
    rm -rf workbench
fi

mkdir -vp workbench && cd workbench

echo "cloning source-code repository"
cp -r ../webapp . && cd webapp && git reset --hard badstuff

#echo "building running eslint..."
# eslint src/

echo "building react app"
npm run build

echo "dockerizing image"
cp -r ../../docker_image  ../
if [ -e ../docker_image/react-webapp ]
then
    rm -rf ../docker_image/react-webapp
fi
cp -r build ../docker_image/react-webapp

cd ../docker_image && docker build -t in-toto-pwnt-but-dockerized .
docker run -p 8080:80 -t in-toto-pwnt-but-dockerized 
