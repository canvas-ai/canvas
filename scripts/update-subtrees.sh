#!/bin/bash

git subtree pull --prefix src/ui canvas-ai/canvas-electron main --squash
git subtree pull --prefix src/server canvas-ai/canvas-server main --squash
