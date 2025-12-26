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
echo -e "$RED sh script.sh sourcedir destdir days(optional) $"
exit 1
fi

if [ ! -d $SOURCEDIR ]
then
echo -e "$RED sourcedir $SOURCEDIR does not exist $NC"
exit 1
fi 
if [ ! -d $DESTDIR ]
then
echo -e "$RED destdir $DESTDIR does not exist $NC"
exit 1
fi 

FILES=$( find $SOURCEDIR -name "*.log" -type f -mtime $DAYS )

echo "$FILES"

if [ ! -z $FILES ]
then
timestamp=$(date +%F-%H-%M)
ZIPFILENAME=$($DESTDIR/app-logs-$timestamp.log)
echo "$FILES | zip -@ -j $ZIPFILENAME"
fi

