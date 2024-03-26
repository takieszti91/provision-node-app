#!/bin/bash

# app_name=sample-nodejs
# port=3000

app_name=sample-node-api
# port=18000

cd /home/vagrant/$app_name
# Only for check npm commands in case of error in Docker build
# sudo apt-get install npm
docker build -t $app_name .

#docker run -p $port:$port -d $app_name
#mv /tmp/docker-node-app\@.service /etc/systemd/system/docker-node-app\@.service
#mv /tmp/docker-node-app\@.service /usr/lib/systemd/system/docker-node-app\@.service
mv /tmp/docker-node-app.service /usr/lib/systemd/system/docker-node-app.service
chown root:root /usr/lib/systemd/system/docker-node-app.service
chmod 644 /usr/lib/systemd/system/docker-node-app.service

# apt install policycoreutils
# restorecon docker-node-app.service

# ln -s /lib/systemd/system/docker-node-app.service /etc/systemd/system/docker-node-app.service
#systemctl daemon-reload
systemctl daemon-reexec

#systemctl start docker-nodejs-app@$app_name
#systemctl enable docker-nodejs-app@$app_name
systemctl start docker-nodejs-app
systemctl enable docker-nodejs-app
