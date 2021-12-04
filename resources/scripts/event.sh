#!/usr/bin/env bash
#******************************************************************************
# Copyright 2019 the original author or authors.                              *
#                                                                             *
# Licensed under the Apache License, Version 2.0 (the "License");             *
# you may not use this file except in compliance with the License.            *
# You may obtain a copy of the License at                                     *
#                                                                             *
# http://www.apache.org/licenses/LICENSE-2.0                                  *
#                                                                             *
# Unless required by applicable law or agreed to in writing, software         *
# distributed under the License is distributed on an "AS IS" BASIS,           *
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.    *
# See the License for the specific language governing permissions and         *
# limitations under the License.                                              *
#******************************************************************************/

#==============================================================================
# SCRIPT:       event.sh
# AUTOHR:       Markus Schneider
# CONTRIBUTERS: Markus Schneider,<YOU>
# DATE:         2019-07-03
# REV:          0.1.0
# PLATFORM:     Noarch
# PURPOSE:      Script for sending a custom event to a logstash instance
#==============================================================================

opts=vd:s:h
##----------------------------------------
## CONFIG
##----------------------------------------
#TIMESTAMP=$(date +%Y-%m-%dT%H:%M:%S.%3N+1:00)
TIMESTAMP=$(date --utc +%FT%T.%3NZ)
ELASTIC_USER=elastic
ELASTIC_PASSWORD=changeme
ELASTIC_INDEX="event"
ELASTIC_DEST=""
VERBOSE=""
SLEEP_TIME=0

SEVERITIES=("UNKNOWN" "HARMLESS" "WARNING" "MINOR" "MAJOR" "CRITICAL" "FATAL")
SEVERITY_IDX=$(($RANDOM % 7))
PAGES=("Landing-Page" "Login-Page" "Product-Page" "Order-Page" "Account-Page")
PAGE_IDX=$(($RANDOM % 5))
CATEGORIES=("Availability" "Accuracy" "Performance")
CATEGORY_IDX=$(($RANDOM % 3))
TEAMS=("Team-A" "Team-B" "Team-C")
TEAM_IDX=$(($RANDOM % 3))
HOSTNAMES=("lx01111" "lx02222" "lx03333" "lx04444" "lx05555")
HOSTNAME_IDX=$(($RANDOM % 5))
CORRELATION_KEY=("CK01111" "CK02222" "CK03333" "CK04444" "CK05555")
CORRELATION_KEY_IDX=$(($RANDOM % 5))
BUSINESS_SERVICES=("Travel Insurance" "Health Insurance" "Life Insurance" "Car Insurance" "Home Insurance")
BUSINESS_SERVICE_IDX=$(($RANDOM % 5))

CLASS="insure69.event.common"
OWNER=${TEAMS[TEAM_IDX]}
SEVERITY=${SEVERITIES[SEVERITY_IDX]}
PRIORITY=$(($RANDOM % 5))
CATEGORY=${CATEGORIES[CATEGORY_IDX]}
CORRELATION_ID=${CORRELATION_KEY[CORRELATION_KEY_IDX]}
DESCRIPTION="End2End Monitoring Event"
DOCUMENTATION="http://www.insure69.de"
HOSTNAME="lxv12345"
IP_ADDR=$(($RANDOM % 100))
SOURCE="End2End"
SUB_SOURCE="Insure69_E2E_Monitor"
ORIGIN="SitePerformer"
SUB_ORIGIN=${PAGES[PAGE_IDX]}
IT_SERVICE="Web-Portal"
BUSINESS_SERVICE=${BUSINESS_SERVICES[BUSINESS_SERVICE_IDX]}
TAGS="[\"Insure69.com\",\"Insure69.de\"]"
ACTION="create-incident"
JSON_OWNER="[ { \"orga_unit\": \"$OWNER\", \"action\": \"$ACTION\" } ]"

JSON_MESSAGE="{"
JSON_MESSAGE="$JSON_MESSAGE \"elastic_index\":\"$ELASTIC_INDEX\","
JSON_MESSAGE="$JSON_MESSAGE \"@timestamp\":\"$TIMESTAMP\","
JSON_MESSAGE="$JSON_MESSAGE \"created_at\":\"$TIMESTAMP\","
JSON_MESSAGE="$JSON_MESSAGE \"class\":\"$CLASS\","
JSON_MESSAGE="$JSON_MESSAGE \"owner\":$JSON_OWNER,"
JSON_MESSAGE="$JSON_MESSAGE \"severity\":\"$SEVERITY\","
JSON_MESSAGE="$JSON_MESSAGE \"priority\":\"$PRIORITY\","
JSON_MESSAGE="$JSON_MESSAGE \"category\":\"$CATEGORY\","
JSON_MESSAGE="$JSON_MESSAGE \"correlation_id\": \"$CORRELATION_ID\","
JSON_MESSAGE="$JSON_MESSAGE \"description\": \"$DESCRIPTION\","
JSON_MESSAGE="$JSON_MESSAGE \"documentation\": \"$DOCUMENTATION\","
JSON_MESSAGE="$JSON_MESSAGE \"hostname\": \"$HOSTNAME\","
JSON_MESSAGE="$JSON_MESSAGE \"ip_addr\": \"192.168.1.$IP_ADDR\","
JSON_MESSAGE="$JSON_MESSAGE \"source\": \"$SOURCE\","
JSON_MESSAGE="$JSON_MESSAGE \"sub_source\": \"$SUB_SOURCE\","
JSON_MESSAGE="$JSON_MESSAGE \"origin\": \"$ORIGIN\","
JSON_MESSAGE="$JSON_MESSAGE \"sub_origin\": \"$SUB_ORIGIN\","
JSON_MESSAGE="$JSON_MESSAGE \"it_service\": \"$IT_SERVICE\","
JSON_MESSAGE="$JSON_MESSAGE \"business_service\": \"$BUSINESS_SERVICE\","
JSON_MESSAGE="$JSON_MESSAGE \"tags\": $TAGS"
JSON_MESSAGE="$JSON_MESSAGE }"

##----------------------------------------
## SUB ROUTINES
##----------------------------------------
usage() {
  cat<<EOF
  usage: ${0##*/} [-v -h -x option1 -y option2 ...]
        -v verbose
        -d destination, arg(s): 'es' | 'ls'
        -s sleep time (sec.): default 0
        -h help
EOF
  exit 0;
}

procOpt() {
  while getopts $opts opt
    do
    case $opt in
      v) VERBOSE=vvv;;
      d) ELASTIC_DEST=$OPTARG;;
      s) SLEEP_TIME=$OPTARG;;
      h) usage;;
      \?) echo -e "Invalid option: -$OPTARG\n" >&2; usage; exit 1;;
      :) echo -e "Missing argument for -$OPTARG\n" >&2; usage; exit 1;;
      *) echo -e "Unimplemented option: -$OPTARG\n" >&2; usage; exit 1;;
    esac
  done

  if [ ! "$ELASTIC_DEST" ]
  then
    usage
    exit 1
  fi
}

send_event() {
    if [ "$ELASTIC_DEST" == "es" ]
    then
        ENDPOINT="0.0.0.0:9200"
        if [ "$VERBOSE" == "vvv" ]
        then
            echo "curl -u $ELASTIC_USER:$ELASTIC_PASSWORD -XPOST \"http://${ENDPOINT}/${ELASTIC_INDEX}/_doc\" -H 'Content-Type: application/json' -d \"$JSON_MESSAGE\""
        fi
        if curl -u $ELASTIC_USER:$ELASTIC_PASSWORD -XPOST "http://${ENDPOINT}/${ELASTIC_INDEX}/_doc" -H 'Content-Type: application/json' -d "$JSON_MESSAGE" >> /dev/null 2>&1; then
            echo "SUCCESS - Event was send to elasticsearch."
        else
            echo "ERROR - Event couldn't be send to elasticsearch."
        fi
    elif [ "$ELASTIC_DEST" == "ls" ]
    then
        ENDPOINT="0.0.0.0:5818"
        if [ "$VERBOSE" == "vvv" ]
        then
            echo "curl -u $ELASTIC_USER:$ELASTIC_PASSWORD -XPOST \"http://${ENDPOINT}\" -H 'Content-Type: application/json' -d \"$JSON_MESSAGE\""
        fi
        if curl -u $ELASTIC_USER:$ELASTIC_PASSWORD -XPOST "http://${ENDPOINT}" -H 'Content-Type: application/json' -d "$JSON_MESSAGE" >> /dev/null 2>&1; then
            echo "SUCCESS - Event was send to logstash."
        else
            echo "ERROR - Event couldn't be send to logstash."
        fi
    fi
}

run() {
    if [ "$SLEEP_TIME" -ne "0" ]
    then
        while true; do
            send_event
            sleep $SLEEP_TIME
        done
    else
        send_event
    fi
}

##----------------------------------------
## MAIN
##----------------------------------------
main() {
    procOpt "$@"
    run
}

main "$@"
