#!/bin/bash

number=$(id -u)

if [ $number -ne 0 ]
then
echo " user is not a root "
exit 1
else 
echo " user is root "
fi

dnf list installed git

if [ $? -ne 0 ]
then
echo " git not installed"
else
echo "git installed already"
fi
