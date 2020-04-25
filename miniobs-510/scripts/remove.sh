#!/bin/bash
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
# SCRIPT:       remove.sh
# AUTOHR:       Markus Schneider
# CONTRIBUTERS: Markus Schneider,<YOU>
# DATE:         2019-05-26
# REV:          0.1.0
# PLATFORM:     Noarch
# PURPOSE:      remove all elastmon docker images
#==============================================================================

##----------------------------------------
## CONFIG
##----------------------------------------
USER=$(id -un)
GROUP=$(id -gn)
TIMESTAMP=$(date +%Y-%m-%dT%H:%M:%S.%3NZ)
DOCKER_IMAGES=( "docker.elastic.co/elasticsearch/elasticsearch" \
                "docker.elastic.co/kibana/kibana" \
                "docker.elastic.co/logstash/logstash" \
                "docker.elastic.co/beats/auditbeat" \
                "docker.elastic.co/beats/filebeat" \
                "docker.elastic.co/beats/metricbeat" \
                "docker.elastic.co/beats/packetbeat" \
                "docker.elastic.co/beats/heartbeat" \
                "docker.elastic.co/beats/journalbeat" \
                "docker.elastic.co/apm/apm-server" \
                "setup_setup" \
                "docker/compose" )

##----------------------------------------
## SETUP FUNCTIONS
##----------------------------------------
run_remove() {
    printf "==> Run 'remove.sh' for %s\n" $PROJECT_NAME
    docker-compose -f $PROJECT_HOME/docker-compose.yml down -v

    for DOCKER_IMAGE in ${DOCKER_IMAGES[@]}; do
        docker rmi $(docker images $DOCKER_IMAGE -q)
    done
}

##----------------------------------------
## MAIN
##----------------------------------------
remove_main() {
   run_remove
}

remove_main "$@"