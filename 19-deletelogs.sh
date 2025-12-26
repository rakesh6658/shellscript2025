#!/bin/bash


RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'
sourcedir=$1



if [ ! -d $sourcedir ]
then
echo -e "SOURCEDIR $sourcedir does not exist"
exit 1
fi
FILESTODELETE=$(find $sourcedir -name "*.log" -type f -mtime +14)
while IFS= read -r filepath
do
echo "$filepath"
rm -rf $filepath
done <<< $FILESTODELETE
