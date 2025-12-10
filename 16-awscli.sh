#!/bin/bash

AMI_ID=ami-09c813fb71547fc4f
sg_id=sg-08c5ef089ab83c3ce


for instance in $@
do
 instance_id = $(aws ec2 run-instances \
    --image-id $AMI_ID \
    --instance-type t3.micro \
    --security-group-ids $sg_id \
    --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value='$instance'}]' \
    --query 'Instances[0].InstanceId' \
    --output text)
    done

