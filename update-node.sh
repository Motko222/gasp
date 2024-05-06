#!/bin/bash

cd ~/avs-operator-setup
git pull
docker compose pull
docker compose down
docker compose up -d
