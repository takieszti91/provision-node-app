#!/bin/bash

# app_name=sample-nodejs
# port=3000

app_name=sample-node-api
port=18000

cd /home/vagrant/$app_name
# Only for check npm commands in case of error in Docker build
# apt-get install --assume-yes npm
docker build -t $app_name .
docker run -p $port:$port -d $app_name
