#!/bin/bash

number=$(id -u)

if [ $number -ne 0 ]
then
echo " user is not a root "
exit 1
else 
echo " user is root "
fi

dnf remove maven

if [ $? -ne 0 ]
then
echo " git not installed"
dnf install git -y
if [ $? -ne 0 ]
then
echo "instalation of git failure"
else
echo "installation of git success"
fi
else
echo "git installed already"
fi
