output "vpc" {
  value = aws_vpc.vpc_node_app
}

output "ecs_a" {
    value = aws_subnet.ecs_a
}

output "ecs_b" {
    value = aws_subnet.ecs_b
}

output "ecs_c" {
    value = aws_subnet.ecs_c
}

output "elb_a" {
    value = aws_subnet.elb_a
}

output "elb_b" {
    value = aws_subnet.elb_b
}

output "elb_c" {
    value = aws_subnet.elb_c
}

output "load_balancer_sg" {
  value = aws_security_group.load_balancer
}

output "ecs_sg" {
    value = aws_security_group.ecs_task
}
