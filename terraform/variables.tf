variable "aws_region" {
    type = string
    default = "eu-central-1"
    # default = "eu-west-1"
}

variable "ecr_repo" {
    type = string
    default = "sample-node-api"
}

variable "force_image_rebuild" {
  type    = bool
  default = false
}

variable "dkr_img_src_path" {
    type = string
    default = "/home/vagrant/sample-node-api"
}
