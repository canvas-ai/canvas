#!/bin/bash

git subtree pull --prefix src/ui https://github.com/canvas-ai/canvas-electron main --squash
git subtree pull --prefix src/server https://github.com/canvas-ai/canvas-server main --squash
