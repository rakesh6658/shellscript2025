#!/bin/bash

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

dnf list installed $1

if [ $? -ne 0 ]
then
echo " $1 not installed"
dnf install $1 -y
validate $? "$1"

else
echo "$1 installed already"
fi

