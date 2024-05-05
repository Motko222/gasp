#!/bin/bash

source ~/.bash_profile

docker_status=$(docker inspect avs-finalizer-node | jq -r .[].State.Status)
id=gasp-$GASP_ID
chain=holesky
bucket=node

case $docker_status in
  running) status="ok" ;;
  restarting) status="warning"; message="docker restarting" ;;
  *) status="error"; message="docker not running" ;;
esac

# show json output 
cat << EOF
{
  "id":"$id",
  "machine":"$MACHINE",
  "chain":"$chain",
  "type":"node",
  "status":"$status",
  "message":"$message",
  "updated":"$(date --utc +%FT%TZ)",
  "version":"$version"
}
EOF

# send data to influxdb
if [ ! -z $INFLUX_HOST ]
then
 curl --request POST \
 "$INFLUX_HOST/api/v2/write?org=$INFLUX_ORG&bucket=$bucket&precision=ns" \
  --header "Authorization: Token $INFLUX_TOKEN" \
  --header "Content-Type: text/plain; charset=utf-8" \
  --header "Accept: application/json" \
  --data-binary "
    status,node=$id,machine=$MACHINE status=\"$status\",message=\"$message\",version=\"$version\",url=\"$url\",chain=\"$chain\" $(date +%s%N) 
    "
fi
