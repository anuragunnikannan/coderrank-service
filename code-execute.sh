#!/bin/bash

dir_name=$1
password=$2
username=$3
internal_ip=$4
mode=$5
language=$6

command="echo $password | sudo -S -p '' bash -c 'docker run --rm --network=none --memory=128m -i -v /home/anurag/codes/$dir_name:/codes/ coderrank-execution-service python3 runner.py $mode $language'"

echo $command