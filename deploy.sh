#!/bin/bash
#
# deploy command line because ant doesn't remember the password
#
/usr/local/appengine-java-sdk/bin/appcfg.sh --oauth2 -e fileformat@gmail.com update www/
