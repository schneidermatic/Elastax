#!/bin/bash

set -euo pipefail

cacert=/usr/share/logstash/config/certificates/certs/ca/ca.crt
# Wait for ca file to exist before we continue. If the ca file doesn't exist
# then something went wrong.
while [ ! -f $cacert ]
do
  TIMESTAMP=$(date +%Y-%m-%dT%H:%M:%S.%3N+01:00)
  printf "[%s] Wait for certs...\n" $TIMESTAMP
  sleep 2
done
ls -l $cacert

es_url=https://elasticsearch:9200
# Wait for Elasticsearch to start up before doing anything.
while [[ "$(curl -u "elastic:${ELASTIC_PASSWORD}" --cacert $cacert -s -o /dev/null -w '%{http_code}' $es_url)" != "200" ]]; do 
  TIMESTAMP=$(date +%Y-%m-%dT%H:%M:%S.%3N+01:00)
  printf "[%s] Wait for elasticsearch...\n" $TIMESTAMP
  sleep 5
done

# Set the password for the logstash user.
# REF: https://www.elastic.co/guide/en/x-pack/6.0/setting-up-authentication.html#set-built-in-user-passwords

echo "Set password ${ELASTIC_PASSWORD} for the logstash user."

until curl -u "elastic:${ELASTIC_PASSWORD}" --cacert $cacert -s -H 'Content-Type:application/json' \
     -XPUT $es_url/_security/user/logstash_system/_password \
     -d "{\"password\": \"${ELASTIC_PASSWORD}\"}"
do
    sleep 2
    echo "Retrying to set password for user 'logstash'"
done


echo "=== CREATE Keystore for Logstash ==="
if [ -f /usr/share/logstash/config/logstash.keystore ]; then
    echo "Remove old logstash.keystore"
    rm /usr/share/logstash/config/logstash.keystore
fi
echo "y" | /usr/share/logstash/bin/logstash-keystore create
echo "Setting ELASTIC_PASSWORD..."
(echo "logstash_system" | /usr/share/logstash/bin/logstash-keystore add 'elasticsearch.username' -x)
(echo "$ELASTIC_PASSWORD" | /usr/share/logstash/bin/logstash-keystore add 'ELASTIC_PASSWORD' -x)

#mv /usr/share/logstash/config/logstash.keystore /config/logstash/logstash.keystore
