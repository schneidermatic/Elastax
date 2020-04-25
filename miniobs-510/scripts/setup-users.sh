#!/bin/bash

set -euo pipefail

cacert=/usr/share/elasticsearch/config/certificates/certs/ca/ca.crt
# Wait for ca file to exist before we continue. If the ca file doesn't exist
# then something went wrong.
while [ ! -f $cacert ]
do
  TIMESTAMP=$(date +%Y-%m-%dT%H:%M:%S.%3N+01:00)
  printf "[%s] Wait for certs ...\n" $TIMESTAMP
  sleep 2
done
ls -l $cacert

es_url=https://elastic:${ELASTIC_PASSWORD}@elasticsearch:9200
# Wait for Elasticsearch to start up before doing anything.

echo "curl -s --cacert $cacert $es_url -o /dev/null"

until curl -s --cacert $cacert $es_url -o /dev/null; do
    TIMESTAMP=$(date +%Y-%m-%dT%H:%M:%S.%3N+01:00)
    printf "[%s] Wait for elasticsearch ...\n" $TIMESTAMP
    sleep 1
done

# Set the password for the kibana user.
# REF: https://www.elastic.co/guide/en/x-pack/6.0/setting-up-authentication.html#set-built-in-user-passwords
until curl --cacert $cacert -s -H 'Content-Type:application/json' \
     -XPUT $es_url/_xpack/security/user/kibana/_password \
     -d "{\"password\": \"${ELASTIC_PASSWORD}\"}"
do
    TIMESTAMP=$(date +%Y-%m-%dT%H:%M:%S.%3N+01:00)
    printf "[%s] Retrying ...\n" $TIMESTAMP
    sleep 2
done

# Set the password for the logstash user.
until curl --cacert $cacert -s -H 'Content-Type:application/json' \
     -XPUT $es_url/_xpack/security/user/logstash_system/_password \
     -d "{\"password\": \"${ELASTIC_PASSWORD}\"}"
do
    TIMESTAMP=$(date +%Y-%m-%dT%H:%M:%S.%3N+01:00)
    printf "[%s] Retrying ...\n" $TIMESTAMP
    sleep 2
done
