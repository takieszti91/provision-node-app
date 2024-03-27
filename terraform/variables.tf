variable "aws_region" {
    type = string
    default = "eu-central-1"
    # default = "eu-west-1"
}

variable "ecr_repo" {
    type = string
    default = "sample-node-api"
}
