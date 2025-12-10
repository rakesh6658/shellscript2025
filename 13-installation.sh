#!/bin/bash

LOG_DIR="/var/log/shellscript"
file= echo "$0"  | cut -d "." -f1

file_name="$LOG_DIR/$file.log"

mkdir -p $LOG_DIR

number=$(id -u)

if [ $number -ne 0 ]
then
echo " user is not a root "
exit 1
else 
echo " user is root "
fi
validate() {
    if [ $1 -ne 0 ]
then
echo "instalation of $2 failure"
else
echo "installation of $2 success"
fi
}

dnf list installed $1 &>> $file_name

if [ $? -ne 0 ]
then
echo " $1 not installed"
dnf install $1 -y &>> $file_name
validate $? "$1"

else
echo "$1 installed already"
fi

