#!/bin/bash
#Pipay-dev-Web-App
#SERVER="192.168.10.136"
instance_id=$(curl -s -w '\n' http://169.254.169.254/latest/meta-data/instance-id)
SERVER=$1
Process=$3
#PORT=80
PORT=$2
nc -z -v -w5 $SERVER $PORT
result1=$?
echo "StatusCheck_$Process"_"$PORT"

if [  "$result1" != 0 ]; then
#   echo "NginxStatusCheck$PORT Failed"
  aws cloudwatch put-metric-data --namespace pipaydevNamespace --metric-name "StatusCheck_$Process"_"$PORT" --dimension InstanceId=$instance_id --value 1 --region us-east-1
else
#   echo "NginxStatusCheck$PORT Passed"
  aws cloudwatch put-metric-data --namespace pipaydevNamespace --metric-name "StatusCheck_$Process"_"$PORT" --dimension InstanceId=$instance_id --value 0 --region us-east-1
fi
