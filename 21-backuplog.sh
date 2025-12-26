#!/bin/bash

user_id=$(id -u)

if [ $user_id -ne 0 ]
then
echo "Do not have root access"
exit 1
fi
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'
SOURCEDIR=$1
DESTDIR=$2
DAYS=${3:-14}

if [ $# -lt 2 ]
then
echo -e "sh script.sh sourcedir destdir days(optional)"
exit 1
fi

# if [ ! -d $SOURCEDIR ]
# then
# echo "source 
