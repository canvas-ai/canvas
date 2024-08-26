#!/bin/bash

git subtree pull --prefix src/ui canvas-ui main --squash
git subtree pull --prefix src/server canvas-server main --squash
