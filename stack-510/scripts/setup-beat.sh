#!/bin/bash

set -euo pipefail

beat=${BEAT_TYPE}

until curl -s "http://kibana:5601/login" | grep "Loading Kibana" > /dev/null; do
	  echo "Waiting for kibana ..."
	  sleep 1
done

cacert=/usr/share/${beat}/certs/ca/ca.crt

# Wait for ca file to exist before we continue. If the ca file doesn't exist
# then something went wrong.
while [ ! -f $cacert ]
do
  sleep 2
done

es_url=https://elasticsearch:9200

# Wait for Elasticsearch to start up before doing anything.
while [[ "$(curl -u "elastic:${ELASTIC_PASSWORD}" --cacert $cacert -s -o /dev/null -w '%{http_code}' $es_url)" != "200" ]]; do 
    sleep 5 
done

# Set the password for the beats_system user.
# REF: https://www.elastic.co/guide/en/x-pack/6.0/setting-up-authentication.html#set-built-in-user-passwords
until curl -u "elastic:${ELASTIC_PASSWORD}" --cacert $cacert -s -H 'Content-Type:application/json' \
     -XPUT $es_url/_security/user/beats_system/_password \
     -d "{\"password\": \"${ELASTIC_PASSWORD}\"}"
do
    sleep 2
    printf "Waiting for elasticsearch ...\n"
done

if [ "$beat" == "auditbeat" ]; then
  chmod u=rw,go=r,o=r /usr/share/$beat/${beat}.yml
  #chown root:${beat} /usr/share/${beat}/${beat}.yml
  chown root:1000 /usr/share/${beat}/${beat}.yml
  #chown root:root /usr/share/${beat}/${beat}.yml
fi

ls -la /usr/share/$beat/${beat}.yml
#chown root:root /usr/share/${beat}/${beat}.yml

printf "Creating keystore ...\n"
# create beat keystore
cd /usr/share/${beat}
$beat keystore create --force
ls -la /usr/share/${beat}/data
#chown root:root /usr/share/${beat}/data/${beat}.keystore

if [ "$beat" == "auditbeat" ]; then
  chown root:1000 /usr/share/${beat}/data/beats.keystore
fi

printf "Adding ELASTIC_PASSWORD to keystore ...\n"
echo "$ELASTIC_PASSWORD" | ${beat} --strict.perms=false keystore add ELASTIC_PASSWORD --stdin
${beat} --strict.perms=false keystore list

printf "Setting up dashboards ...\n"
# Load the sample dashboards for the Beat.
# REF: https://www.elastic.co/guide/en/beats/metricbeat/master/metricbeat-sample-dashboards.html
#${beat} --strict.perms=false setup -v

${beat} --strict.perms=false setup -e \
  -E output.logstash.enabled=false \
  -E output.elasticsearch.hosts=["$es_url"] \
  -E output.elasticsearch.username=elastic \
  -E output.elasticsearch.password=${ELASTIC_PASSWORD} \
  -E output.elasticsearch.ssl.verification_mode=none \
  -E setup.kibana.host=kibana:5601
