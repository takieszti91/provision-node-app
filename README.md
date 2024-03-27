# Provision Node.js App
I choose this Node.js App to provision:<br />
[zowe/sample-node-api: A sample node js api for finding cars and accounts for a dealership](https://github.com/zowe/sample-node-api)

## Used technologies

### AWS

I used AWS ECS, because this is effective, scalable and cheap for small projects.

#### Components
- AWS VPC
    - for networking
- AWS ECR
    - for store app image
- AWS ECS
    - for running the container
- AWS IAM
    - for grant access to services
- AWS ELB
    - for load balancing
- AWS Auto Scaling
    - for scale the app

### IaC

I used Terraform to provision the infrastructure.

## AWS Account

You need an AWS Account and an IAM User with AdministratorAccess to provision the Node.js app to AWS.

## Testing from Vagrant

If you have Vagrant and VirtualBox, you can test this easily.

I included all needed tools to the VM except from your credentials.

### AWS credentials

For simplicity place your ```aws_accessKeys.csv``` (IAM User's access keys file) to this repo's root directory, before you first start the VM. You can download this file when you create your access key or write your existing one to this file in this format:
```
Access key ID,Secret access key
MY_ACCESS_KEY_ID,MY_SECRET_ACCESS_KEY
```

### Start and login to the VM

Use ```vagrant up``` command to start the VM and then ```vagrant ssh``` to login to the VM via SSH.

You can destroy the VM if not needed anymore with ```vagrant destroy```.

More information about Vagrant:<br />
[Documentation | Vagrant | HashiCorp Developer](https://developer.hashicorp.com/vagrant/docs)

### Try Node.js app from Docker under the VM

When VM runs first time, Node.js app is running in a Docker container.

You can test the container for example with this command:<br />
```curl localhost:18000/accounts```

This will provide some json output.

You can get this json from your host machine too from a browser. Perhaps you have to wait some time after VM boot to try this.

If the container doesn't run, you can start with this command:<br />
```docker run -p 18000:18000 -d sample-node-api```

### AWS provision with Terraform
Vagrant also set your AWS credentials from ```aws_accessKeys.csv```, so you don't need to care about them now.

You can test AWS provision with Terraform from ```/vagrant/terraform``` directory

## Testing from other environment

### AWS credentials

If you don't want to use Vagrant, please set your credentials with one of these commands (depending on which AWS CLI version you use):

```aws configure```<br />
or<br />
```awsv2 configure```

In this case you also need to create ```variables_secure.tf``` inside ```terraform``` directory whith this content:

```
variable "aws_account" {
    type = string
    default = "0123456789"
}
```

Please replace the numbers with your AWS Account ID!

You can get your Account ID with one of these commands:

```aws sts get-caller-identity```<br />
or<br />
```awsv2 sts get-caller-identity```

### Needed Tools

In this case you also need to install:
- [Terraform](https://developer.hashicorp.com/terraform/install)
- [Docker](https://docs.docker.com/engine/install/)
- [AWS CLI v2](https://pypi.org/project/awscliv2/)

Docker and AWS CLI v2 needed too, because I used them from Terraform (```terraform/modules/ecr/main.tf```) to build the app image and push it to AWS ECR.

## Provision with Terraform

You need to run terraform from ```terraform``` directory.

You can use the basic Terraform commands to provision or update the infrastructure and the app to AWS:

```
terraform init
terraform plan
terraform apply
```

You can destroy the infrastructure if not needed anymore:

```
terraform destroy
```

More information about Terraform:<br />
[Terraform | HashiCorp Developer](https://developer.hashicorp.com/terraform)

### Note

Please note, that ```terraform/modules/ecr/main.tf``` should be use LF (Linux style) line endings! CRLF (Windows style) is not acceptable, because it places ```\r``` symbol to the end of the commands! Search for ```dkr_build_cmd``` in this file for more information.
