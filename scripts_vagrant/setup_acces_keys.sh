#!/bin/bash

access_key_file=/vagrant/aws_accessKeys.csv
# awsv2 configure import --csv $access_key_file
access_key_id=$(tail -n 1 $access_key_file|sed 's|^\(.*\),.*$|\1|')
secret_access_key=$(tail -n 1 $access_key_file|sed 's|^.*,\(.*\)$|\1|')

# export AWS_ACCESS_KEY_ID=$access_key_id
# export AWS_SECRET_KEY_ID=$secret_access_key
awsv2 configure set aws_access_key_id $access_key_id
awsv2 configure set aws_secret_access_key $secret_access_key
