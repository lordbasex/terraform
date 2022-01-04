resource "aws_ecs_cluster" "cluster" {
  name = var.project_name

  tags = {
    Terraform    = "true"
    Environment  = var.environment
    project_name = var.project_name
  }
}

resource "aws_cloudwatch_log_group" "log-group" {
  name = "${var.project_name}-logs"

  tags = {
    Terraform    = "true"
    Environment  = var.environment
    project_name = var.project_name
  }
}