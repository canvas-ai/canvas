#!/bin/bash

git subtree pull --prefix src/ui canvas-electron main --squash
cd src/ui && npm install

# TODO: Implement a propper installation script
