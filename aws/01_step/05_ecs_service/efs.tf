# efs.ft | Amazon Elastic File System

resource "aws_efs_file_system" "main" {
  creation_token = "${var.project_name}-efs"

  tags = {
    Name         = "${var.project_name}-${var.environment}-efs"
    Terraform    = "true"
    Environment  = var.environment
    project_name = var.project_name
  }
}

resource "aws_efs_mount_target" "main" {
  count           = length(data.terraform_remote_state.vpc.outputs.private_subnets)
  file_system_id  = aws_efs_file_system.main.id
  subnet_id       = element(data.terraform_remote_state.vpc.outputs.private_subnets, count.index)
  security_groups = [aws_security_group.alb.id]
}
