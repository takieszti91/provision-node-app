variable "aws_region" {}
variable "aws_account" {}
variable "ecr_repo" {}
variable "ecs_target_group" {}
variable "ecs_subnet_a" {}
variable "ecs_subnet_b" {}
variable "ecs_subnet_c" {}
variable "ecs_sg" {}
variable "ecs_role" {}
variable "container_name" {
    default = "node-app"
}
