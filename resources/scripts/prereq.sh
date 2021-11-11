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
# SCRIPT:       prereq.sh
# AUTOHR:       Markus Schneider
# CONTRIBUTERS: Markus Schneider,<YOU>
# DATE:         2021-10-07
# REV:          0.1.1
# PLATFORM:     Noarch
# PURPOSE:      set-prereq the elastic-stack environment
#==============================================================================

##----------------------------------------
## SETUP FUNCTIONS
##----------------------------------------
set_prereq() {
    echo "* - nofile 65536" >> /etc/security/limits.conf
    echo "* - memlock unlimited" >> /etc/security/limits.conf
    echo "* - fzise unlimited" >> /etc/security/limits.conf
    echo "vm.max_map_count=262144" > /etc/sysctl.d/max_map_count.conf
    echo "vm.swappiness=0" > /etc/sysctl.d/swappiness.conf
    echo "*    soft nproc  65535" >> /etc/security/limits.conf
    echo "*    hard nproc  65536" >> /etc/security/limits.conf
    echo "*    soft nofile 65535" >> /etc/security/limits.conf
    echo "*    hard nofile 65536" >> /etc/security/limits.conf
    echo "root soft nproc  65536" >> /etc/security/limits.conf
    echo "root hard nproc  65536" >> /etc/security/limits.conf
    echo "root soft nofile 65536" >> /etc/security/limits.conf
    echo "root hard nofile 65536" >> /etc/security/limits.conf

    echo "session required pam_limits.so" >> "/etc/pam.d/common-session"

    echo "DefaultLimitNOFILE=65536" >> /etc/systemd/system.conf
    echo "DefaultLimitNOFILE=65536" >> /etc/systemd/user.conf

    ulimit -a
    sysctl -a
}

##----------------------------------------
## MAIN
##----------------------------------------
run_main() {
   set_prereq
}

run_main "$@"
