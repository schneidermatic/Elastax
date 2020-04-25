#/bin/ash

confdir="${PWD}/resources"

chown -R 1000:1000 "$confdir"
find "$confdir" -type f -name "*.keystore" -exec chmod go-wrx {} \;
find "$confdir" -type f -name "*.yml" -exec chmod go-wrx {} \;

#if [ -f "$confdir/elasticsearch/elasticsearch.keystore" ]; then
#    rm "$confdir/elasticsearch/elasticsearch.keystore"
#fi

PW=$(openssl rand -base64 16;)
ELASTIC_PASSWORD="${ELASTIC_PASSWORD:-$PW}"
export ELASTIC_PASSWORD

# setup elasticsearch (and system passwords)
printf "\n%s\n" "----------------------------------------"
printf "==> Running 'setup-elasticsearch.sh'\n"
printf "%s\n" "----------------------------------------"
docker-compose run --rm -e ELASTIC_PASSWORD=$ELASTIC_PASSWORD elasticsearch /usr/local/bin/setup-elasticsearch.sh

printf "==> Starting Elasticsearch...\n"
docker-compose up -d elasticsearch

printf "==> Running 'setup-users.sh'\n"
docker exec -i -e ELASTIC_PASSWORD=$ELASTIC_PASSWORD elasticsearch /usr/local/bin/setup-users.sh

## setup kibana
printf "\n%s\n" "----------------------------------------"
printf "==> Running 'setup-kibana.sh'\n"
printf "%s\n" "----------------------------------------"
docker-compose run --rm -e ELASTIC_PASSWORD=$ELASTIC_PASSWORD kibana /usr/local/bin/setup-kibana.sh
printf "==> Starting Kibana...\n"
docker-compose up -d kibana

## setup logstash (and system passwords)
printf "\n%s\n" "----------------------------------------"
printf " Running 'setup-logstash.sh'\n"
printf "%s\n" "----------------------------------------"
docker-compose run --rm -e ELASTIC_PASSWORD=$ELASTIC_PASSWORD logstash /usr/local/bin/setup-logstash.sh
printf "==> Starting Logstash...\n"
docker-compose up -d logstash

## setup auditbeat
export BEAT_TYPE="auditbeat"
printf "\n%s\n" "----------------------------------------"
printf " Running 'setup-beat.sh' for BEAT_TYPE=%s\n" $BEAT_TYPE
printf "%s\n" "----------------------------------------"
docker-compose run --rm -e ELASTIC_PASSWORD=$ELASTIC_PASSWORD -e BEAT_TYPE=$BEAT_TYPE auditbeat /usr/local/bin/setup-beat.sh
printf "==> Starting auditbeat...\n"
docker-compose up -d auditbeat

## setup filebeat
export BEAT_TYPE="filebeat"
printf "\n%s\n" "----------------------------------------"
printf " Running 'setup-beat.sh' for BEAT_TYPE=%s\n" $BEAT_TYPE
printf "%s\n" "----------------------------------------"
docker-compose run --rm -e ELASTIC_PASSWORD=$ELASTIC_PASSWORD -e BEAT_TYPE=$BEAT_TYPE $BEAT_TYPE /usr/local/bin/setup-beat.sh
printf "==> Starting %s...\n" $BEAT_TYPE
docker-compose up -d $BEAT_TYPE

## setup heartbeat
export BEAT_TYPE="heartbeat"
printf "\n%s\n" "----------------------------------------"
printf " Running 'setup-beat.sh' for BEAT_TYPE=%s\n" $BEAT_TYPE
printf "%s\n" "----------------------------------------"
docker-compose run --rm -e ELASTIC_PASSWORD=$ELASTIC_PASSWORD -e BEAT_TYPE=$BEAT_TYPE $BEAT_TYPE /usr/local/bin/setup-beat.sh
printf "==> Starting %s...\n" $BEAT_TYPE
docker-compose up -d $BEAT_TYPE

## setup metricbeat
export BEAT_TYPE="metricbeat"
printf "\n%s\n" "----------------------------------------"
printf " Running 'setup-beat.sh' for BEAT_TYPE=%s\n" $BEAT_TYPE
printf "%s\n" "----------------------------------------"
docker-compose run --rm -e ELASTIC_PASSWORD=$ELASTIC_PASSWORD -e BEAT_TYPE=$BEAT_TYPE $BEAT_TYPE /usr/local/bin/setup-beat.sh
printf "==> Starting %s...\n" $BEAT_TYPE
docker-compose up -d $BEAT_TYPE

## setup packetbeat
export BEAT_TYPE="packetbeat"
printf "\n%s\n" "----------------------------------------"
printf " Running 'setup-beat.sh' for BEAT_TYPE=%s\n" $BEAT_TYPE
printf "%s\n" "----------------------------------------"
docker-compose run --rm -e ELASTIC_PASSWORD=$ELASTIC_PASSWORD -e BEAT_TYPE=$BEAT_TYPE $BEAT_TYPE /usr/local/bin/setup-beat.sh
printf "==> Starting %s...\n" $BEAT_TYPE
docker-compose up -d $BEAT_TYPE

## setup journalbeat
export BEAT_TYPE="journalbeat"
printf "\n%s\n" "----------------------------------------"
printf " Running 'setup-beat.sh' for BEAT_TYPE=%s\n" $BEAT_TYPE
printf "%s\n" "----------------------------------------"
docker-compose run --rm -e ELASTIC_PASSWORD=$ELASTIC_PASSWORD -e BEAT_TYPE=$BEAT_TYPE $BEAT_TYPE /usr/local/bin/setup-beat.sh
printf "==> Starting %s...\n" $BEAT_TYPE
docker-compose up -d $BEAT_TYPE

# setup apm server
export BEAT_TYPE="apm-server"
printf "\n%s\n" "----------------------------------------"
printf " Running 'setup-beat.sh' for %s\n" $BEAT_TYPE
printf "%s\n" "----------------------------------------"
docker-compose run --rm -e ELASTIC_PASSWORD=$ELASTIC_PASSWORD -e BEAT_TYPE=$BEAT_TYPE $BEAT_TYPE /usr/local/bin/setup-beat.sh
printf "==> Starting %s...\n" $BEAT_TYPE
docker-compose up -d $BEAT_TYPE

printf "Setup completed successfully. To start the stack please run:\n\t docker-compose up -d\n"
printf "\nIf you wish to remove the setup containers please run:\n\tdocker-compose -f docker-compose.yml -f docker-compose.setup.yml down --remove-orphans\n"
printf "\nYou will have to re-start the stack after removing setup containers.\n"
printf "\nYour 'elastic' user password is: $ELASTIC_PASSWORD\n"