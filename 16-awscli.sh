#!/bin/bash

AMI_ID=ami-09c813fb71547fc4f
sg_id=sg-08c5ef089ab83c3ce
HOSTED_ZONE_ID=Z01767341CQ3HG2Z9RB0E
domain_name=joindevops.store

for instance in $@
do
 instance_id=$( aws ec2 run-instances \
    --image-id $AMI_ID \
    --instance-type t3.micro \
    --security-group-ids $sg_id \
    --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value="'${instance}'"}]' \
    --query 'Instances[0].InstanceId' \
    --output text )
   public_ip=$(aws ec2 describe-instances \
  --instance-ids $instance_id \
  --query "Reservations[0].Instances[0].PublicIpAddress" \
  --output text)
  private_ip=$(aws ec2 describe-instances \
  --instance-ids $instance_id \
  --query "Reservations[0].Instances[0].PrivateIpAddress" \
  --output text)
  if [ $instance -eq "frontend" ]
  then

  aws route53 change-resource-record-sets \
  --hosted-zone-id "$HOSTED_ZONE_ID" \
  --change-batch "{
    \"Changes\": [{
      \"Action\": \"CREATE\",
      \"ResourceRecordSet\": {
        \"Name\": \"${instance}.${domain_name}\",
        \"Type\": \"A\",
        \"TTL\": 1,
        \"ResourceRecords\": [{ \"Value\": \"${public_ip}\" }]
      }
    }]
  }"

  else
  aws route53 change-resource-record-sets \
  --hosted-zone-id "$HOSTED_ZONE_ID" \
  --change-batch "{
    \"Changes\": [{
      \"Action\": \"CREATE\",
      \"ResourceRecordSet\": {
        \"Name\": \"${instance}.${domain_name}\",
        \"Type\": \"A\",
        \"TTL\": 1,
        \"ResourceRecords\": [{ \"Value\": \"${private_ip}\" }]
      }
    }]
  }"

  fi


  


    done

echo "$instance_id"
echo "$private_ip"
echo "$public_ip"
