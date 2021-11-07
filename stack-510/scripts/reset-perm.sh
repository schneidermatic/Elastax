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
# SCRIPT:       reset-perm.sh
# AUTOHR:       Markus Schneider
# CONTRIBUTERS: Markus Schneider,<YOU>
# DATE:         2019-05-26
# REV:          0.1.0
# PLATFORM:     Noarch
# PURPOSE:      Reset the user and group permission for $PROJECT_HOME/resources
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
run_reset_perm() {
    printf "==> Run set-perm for the %s dir\n" "$PROJECT_HOME/resources"
    sudo chown -R $USER:$GOUP $PROJECT_HOME/resources
}

##----------------------------------------
## MAIN
##----------------------------------------
reset_perm_main() {
   run_reset_perm
}

reset_perm_main "$@"