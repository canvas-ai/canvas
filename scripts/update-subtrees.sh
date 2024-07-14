#!/bin/bash

git subtree pull --prefix src/ui canvas-electron main --squash
git subtree pull --prefix src/server canvas-server main --squash
