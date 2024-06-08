#!/bin/bash

cd ~/avs-operator-setup
docker-compose up -d
docker logs -n 200 -f avs-finalizer-node
