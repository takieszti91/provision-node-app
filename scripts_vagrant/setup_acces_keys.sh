#!/bin/bash

access_key_file=/vagrant/aws_accessKeys.csv
# awsv2 configure import --csv $access_key_file
access_key_id=$(tail -n 1 $access_key_file|sed 's|^\(.*\),.*$|\1|')
secret_access_key=$(tail -n 1 $access_key_file|sed 's|^.*,\(.*\)$|\1|')

# export AWS_ACCESS_KEY_ID=$access_key_id
# export AWS_SECRET_KEY_ID=$secret_access_key
awsv2 configure set aws_access_key_id $access_key_id
awsv2 configure set aws_secret_access_key $secret_access_key

terraform_secure_variables_file="/vagrant/terraform/variables_secure.tf"
if [ ! -f $terraform_secure_variables_file ]
then
    account_id=$(awsv2 sts get-caller-identity|grep Account|sed "s|^[^0-9]*\([0-9]*\)[^0-9]*$|\1|")
    cat << 'EOF' > $terraform_secure_variables_file
variable "aws_account" {
    type = string
EOF
    echo "    default = \"$account_id\"" >> $terraform_secure_variables_file
    echo "}" >> $terraform_secure_variables_file
fi
