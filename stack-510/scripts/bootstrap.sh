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
# SCRIPT:       bootstrap.sh
# AUTOHR:       Markus Schneider
# CONTRIBUTERS: Markus Schneider,<YOU>
# DATE:         2019-05-26
# REV:          0.1.0
# PLATFORM:     Noarch
# PURPOSE:      Bootstrap script for elastmon 
#==============================================================================

##----------------------------------------
## CONFIG
##----------------------------------------
USER=$(id -un)
GROUP=$(id -gn)
TIMESTAMP=$(date +%Y-%m-%dT%H:%M:%S.%3NZ)

##----------------------------------------
## SETUP FUNCTIONS
##----------------------------------------
run_bootstrap() {
    printf "==> Run 'bootstrap.sh' for %s\n" $PROJECT_NAME
    printf "==> Run docker compose setup\n"
    printf "==> docker-compose run -e PROJECT_NAME=%s -f setup/setup.yml --rm setup\n" $PROJECT_NAME
    docker-compose -f $PROJECT_HOME/setup/setup.yml run -e PROJECT_NAME=$PROJECT_NAME --rm setup
}

##----------------------------------------
## MAIN
##----------------------------------------
bootstrap_main() {
   run_bootstrap
}

bootstrap_main "$@"