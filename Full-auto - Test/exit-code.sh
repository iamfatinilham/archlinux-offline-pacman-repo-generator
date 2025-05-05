#!/bin/bash

code=$1
# if [[ $2 -eq "" ]]
# then
#     echo $code
#     echo
# 
# 
# 
# 
# 
# 
if [[ -f /isotmp/ecode ]]
then
    reason=$(cat /isotmp/ecode)
    ca=1
elif [[ -f ~/isotmp/ecode ]]
then
    reason=$(cat ~/isotmp/ecode)
    ca=1
else
    reason=$2
    ca=0
fi


if [[ $ca -eq 1 ]]
then
    echo $code
    echo $reason
    rm /isotmp/ecode ; rm ~/isotmp/ecode
elif [[ -d /isotmp ]] || [[ -d ~/isotmp ]]
then
    echo $code
    echo $reason
else
    echo "Temporary directoty not found"
    echo "Error Code 23"
fi