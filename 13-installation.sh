#!/bin/bash

number=$(id -u)

if [ $number -ne 0 ]
then
echo " user is not a root "
else 
echo " user is root "
fi