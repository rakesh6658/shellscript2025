#!/bin/bash

LOG_DIR="/var/log/shellscript"
script_name=$(echo "$0"  | cut -d "." -f1)
file_name="$LOG_DIR/$script_name.log"

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


for package in $@
do
dnf list installed $package &>> $file_name

if [ $? -ne 0 ]
then
echo " $package not installed"
dnf install $package -y &>> $file_name
validate $? "$package"

else
echo "$package installed already"
fi

