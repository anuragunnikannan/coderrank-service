#!/bin/bash

# sshpass -p password scp -o StrictHostKeyChecking=no /app/Solution.java anurag@ip:/home/anurag/

command="echo password | sudo -S docker cp /home/anurag/coderrank-query-execution-service/codes/Solution.java java-container:/home/ > /dev/null 2>/dev/null && echo password | sudo -S docker exec -i java-container java /home/Solution.java < /home/anurag/coderrank-query-execution-service/codes/input.txt > /home/anurag/output.txt && cat /home/anurag/output.txt"

# sshpass -p password scp -o StrictHostKeyChecking=no /app/input.sql anurag@ip:/home/anurag/

# command="echo password | sudo -S docker cp /home/anurag/input.sql pg-container:/home/ > /dev/null 2>/dev/null && echo password | sudo -S docker exec -i pg-container psql -U postgres -d postgres < input.sql > /home/anurag/output.txt 2>/dev/null && cat output.txt"

output=`sshpass -p password ssh -q -o StrictHostKeyChecking=no -t anurag@ip ${command}`

echo $output