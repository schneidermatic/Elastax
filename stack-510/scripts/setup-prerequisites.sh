#!/bin/bash

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
