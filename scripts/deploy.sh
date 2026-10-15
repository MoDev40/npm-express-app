#!/bin/bash

##########################
# Author: Muktar
# Date: 10/14/2026
# Version: 1.0.0 
# This deployment script uses release based deployment with self-hosted github actions
###########################

set -e
set -o pipefail

APP_NAME=npm-express-app
# generate release using timestamp
RELEASE=$(date +%F_%H%M%S)

# change directory to releases
cd ~/apps/$APP_NAME/releases

# clone codebase using  generated release directory
git clone https://github.com/MoDev40/npm-express-app.git $RELEASE

cd $RELEASE

# install dependencies 
npm ci
# build codebase
npm run build

cd ..

# link the release to current directory
ln -sfn $RELEASE current 

cd current

# check if app pm2 procees is running and delete
if pm2 describe $APP_NAME >/dev/null 2>&1; then
  pm2 delete $APP_NAME
fi

# start current app pm2 process
pm2 start dist/index.js --name $APP_NAME
# save pm2
pm2 save
# list runing process
pm2 list