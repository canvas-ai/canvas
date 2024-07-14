#!/bin/bash

git subtree pull --prefix src/server canvas-server main --squash
cd src/server && npm install

# TODO: Implement a propper installation script

# Installation types
# - pm2
# - docker
