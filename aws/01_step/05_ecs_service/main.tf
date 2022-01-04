# main.tf

data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket = var.terraform_remote_state_name
    key    = "terraform/${var.aws_region}/vpc/vpc.tfstate"
    region = var.aws_region
  }
}

data "terraform_remote_state" "ecs" {
  backend = "s3"
  config = {
    bucket = var.terraform_remote_state_name
    key    = "terraform/${var.aws_region}/ecs/aws_ecs_cluster.tfstate"
    region = var.aws_region
  }
}

data "aws_elb_hosted_zone_id" "main" {}

data "aws_route53_zone" "selected" {
  name         = var.domain_name
  private_zone = false
}

data "template_file" "env_vars" {
  template = file("env_vars.json")
}

data "aws_ecs_task_definition" "main" {
  task_definition = aws_ecs_task_definition.aws-ecs-task.family
}

resource "aws_cloudwatch_log_group" "log-group" {
  name = "${var.project_name}-logs"

  tags = {
    Name         = "${var.project_name}-${var.environment}-logs"
    Terraform    = "true"
    Environment  = var.environment
    project_name = var.project_name
  }
}

resource "aws_ecs_task_definition" "aws-ecs-task" {
  family = "${var.project_name}-task"

  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  memory                   = "2048"
  cpu                      = "256"
  execution_role_arn       = aws_iam_role.ecsTaskExecutionRole.arn
  task_role_arn            = aws_iam_role.ecsTaskExecutionRole.arn

  volume {
    name = "${var.project_name}-task"
    efs_volume_configuration {
      file_system_id = aws_efs_file_system.main.id
      root_directory = "/"
    }
  }


  container_definitions = <<DEFINITION
[
  {
    "name": "${var.project_name}-task",
    "image": "281479174676.dkr.ecr.us-east-1.amazonaws.com/wiki-ecr:latest",
    "essential": true,
    "portMappings": [
      {
        "protocol": "tcp",
        "containerPort": 80,
        "hostPort": 80
      }
    ],
    "mountPoints": [
      {
        "readOnly": null,
        "containerPath": "/config",
        "sourceVolume": "${var.project_name}-task"
      }
    ],
    "cpu": 256,
    "memory": 1024,
    "memoryReservation": 512,
    "environment": [
      {
        "name": "PGID",
        "value": "1000"
      },
      {
        "name": "PUID",
        "value": "1000"
      },
      {
        "name": "TZ",
        "value": "America/Argentina/Buenos_Aires"
      }
    ],
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-group": "${aws_cloudwatch_log_group.log-group.id}",
        "awslogs-region": "${var.aws_region}",
        "awslogs-stream-prefix": "ecs"
      }
    }
  }
]
DEFINITION

  tags = {
    Name         = "${var.project_name}-${var.environment}-task"
    Terraform    = "true"
    Environment  = var.environment
    project_name = var.project_name
  }
}

#ECS SERVICE
resource "aws_ecs_service" "aws-ecs-service" {
  name                               = "${var.project_name}-svc"
  cluster                            = data.terraform_remote_state.ecs.outputs.cluster_id
  task_definition                    = "${aws_ecs_task_definition.aws-ecs-task.family}:${aws_ecs_task_definition.aws-ecs-task.revision}"
  launch_type                        = "FARGATE"
  scheduling_strategy                = "REPLICA"
  desired_count                      = 1
  force_new_deployment               = true
  deployment_maximum_percent         = 200
  deployment_minimum_healthy_percent = 0

  network_configuration {
    assign_public_ip = false
    security_groups  = [aws_security_group.alb.id]
    subnets          = slice(data.terraform_remote_state.vpc.outputs.private_subnets, 0, length(data.terraform_remote_state.vpc.outputs.private_subnets))
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.target_group.arn
    container_name   = "${var.project_name}-task"
    container_port   = 80
  }

  depends_on = [aws_lb_listener.listener]
}