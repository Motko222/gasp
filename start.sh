#!/bin/bash

cd ~/avs-operator-setup
docker-compose up -d
docker logs -f avs-finalizer-node
