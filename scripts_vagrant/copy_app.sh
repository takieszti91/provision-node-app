#!/bin/bash

# app_name=sample-nodejs
app_name=sample-node-api

if [ ! -d $app_name ]
then
    # git clone https://github.com/digitalocean/$app_name.git
    git clone https://github.com/zowe/$app_name.git

    chown -R vagrant:vagrant $app_name
    if [ -f Dockerfile ]
    then
        mv Dockerfile $app_name/
    fi
fi
