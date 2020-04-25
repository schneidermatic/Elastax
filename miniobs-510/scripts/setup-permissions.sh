#!/bin/bash


chown 1000 -R /resources
find /resources -type f -name "*.keystore" -print -exec chmod go-wrx {} \;
find /resources -type f -name "*.yml" -print -exec chmod go-wrx {} \;
