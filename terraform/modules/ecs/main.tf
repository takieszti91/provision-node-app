resource "aws_ecs_task_definition" "backend_task" {
    family = "backend_node_app_family"

    // Fargate is a type of ECS that requires awsvpc network_mode
    requires_compatibilities = ["FARGATE"]
    network_mode = "awsvpc"

    // Valid sizes are shown here: https://aws.amazon.com/fargate/pricing/
    memory = "512"
    cpu = "256"

    // Fargate requires task definitions to have an execution role ARN to support ECR images
    execution_role_arn = var.ecs_role.arn
    task_role_arn = var.ecs_role.arn

    tags = {
        Project = "provision-node-app"
    }

    container_definitions = <<EOT
[
    {
        "name": "${var.container_name}",
        "image": "${var.aws_account}.dkr.ecr.${var.aws_region}.amazonaws.com/${var.ecr_repo}:latest",
        "memory": 512,
        "essential": true,
        "portMappings": [
            {
                "containerPort": 18000,
                "protocol": "tcp",
                "hostPort": 18000
            }
        ]
    }
]
EOT
}

resource "aws_ecs_cluster" "backend_cluster" {
    name = "backend_cluster_node_app"
    setting {
        name = "containerInsights"
        value = "enabled"
    }

    tags = {
        Project = "provision-node-app"
    }
}

resource "aws_ecs_service" "backend_service" {
    name = "backend_service"

    cluster = aws_ecs_cluster.backend_cluster.id
    task_definition = aws_ecs_task_definition.backend_task.arn

    launch_type = "FARGATE"
    platform_version = "1.4.0"
    desired_count = 1

    lifecycle {
        ignore_changes = [ desired_count ]
    }

    network_configuration {
        subnets = [ var.ecs_subnet_a.id, var.ecs_subnet_b.id, var.ecs_subnet_c.id ]
        security_groups = [ var.ecs_sg.id ]
        assign_public_ip = true
    }

    load_balancer {
        target_group_arn = var.ecs_target_group.arn
        container_name = var.container_name
        container_port = 18000
    }
}
