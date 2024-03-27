variable "aws_account" {}

variable "aws_region" {}

variable "ecr_repo" {}

variable "force_image_rebuild" {
  type    = bool
  default = false
}

variable "dkr_img_src_path" {
    type = string
    default = "/home/vagrant/sample-node-api"
}
