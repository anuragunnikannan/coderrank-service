#!/bin/bash

dir_name=$1
password=$2
username=$3
internal_ip=$4

command="echo $password | sudo -S -p '' bash -c 'docker run --rm --network=none -i -v /home/anurag/codes/$dir_name:/app python:3.11-slim python3 /app/solution.py < /home/anurag/codes/$dir_name/input.txt'"


output=`sshpass -p $password ssh -q -o StrictHostKeyChecking=no -t $username@$internal_ip $command`

echo $output