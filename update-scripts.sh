#!/bin/bash

cd ~/scripts/gasp
git stash push --include-untracked
git pull
chmod +x *.sh
