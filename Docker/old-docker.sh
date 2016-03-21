#!/usr/bin/env bash

export PATH=/c/Program\ Files/Boot2Docker\ for\ Windows/:$PATH
if [[ `boot2docker status` == "running" ]];then
  echo "boot2docker is already running..."
else
  boot2docker up
fi
eval `boot2docker shellinit`
docker --version
