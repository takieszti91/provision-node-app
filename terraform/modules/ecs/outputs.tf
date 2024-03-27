output "ecs_cluster" {
  value = aws_ecs_cluster.backend_cluster
}

output "ecs_service" {
  value = aws_ecs_service.backend_service
}
