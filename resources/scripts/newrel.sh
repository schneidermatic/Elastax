#!/usr/bin/env bash
#******************************************************************************
# Copyright 2020 the original author or authors.                              *
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
# SCRIPT:       nextrel.sh
# AUTOHR:       Markus Schneider
# CONTRIBUTERS: Markus Schneider,<YOU>
# DATE:         2021-10-07
# REV:          0.1.1
# PLATFORM:     Noarch
# PURPOSE:      define new elastic release in '.env' file
#==============================================================================

##----------------------------------------
## SETUP FUNCTIONS
##----------------------------------------
newrel() {
    for file in $(find $PROJECT_HOME -name '.env'); do
      grep -rl ELASTIC_RELEASE $file | xargs sed -i "s/ELASTIC_RELEASE=.*/$NEW_RELEASE/g"
    done
}

##----------------------------------------
## MAIN
##----------------------------------------
run_main() {
   newrel
}

run_main "$@"
