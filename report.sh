#!/bin/bash

path=$(cd -- $(dirname -- "${BASH_SOURCE[0]}") && pwd)
folder=$(echo $path | awk -F/ '{print $NF}')
json=~/logs/report-$folder
source ~/.bash_profile

docker_status=$(docker inspect avs-finalizer-node | jq -r .[].State.Status)
id=$GASP_ID
network=testnet
chain=holesky
group=node
owner=$OWNER

case $docker_status in
  running) status="ok" ;;
  restarting) status="warning"; message="docker restarting" ;;
  *) status="error"; message="docker not running" ;;
esac

cat >$json << EOF
{
  "updated":"$(date --utc +%FT%TZ)",
  "measurement":"report",
  "tags": {
         "id":"$folder",
         "machine":"$MACHINE",
         "grp":"node",
         "owner":"$OWNER"
  },
  "fields": {
        "network":"$network",
        "chain":"$chain",
        "status":"$status",
        "message":"$message",
        "version":"$version"
  }
}
EOF
cat $json
