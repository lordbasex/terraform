# VPC
output "vpc_id" {
  description = "The ID of the VPC"
  value       = data.terraform_remote_state.vpc.outputs.vpc_id
}

# SG ID
output "security_groups_id" {
  description = "The ID of the SG"
  value       = aws_security_group.alb.id
}

# aws_efs_file_system
output "efs_file_system" {
  description = "The Name, ID of the EFS"
  value       = [aws_efs_file_system.main.creation_token, aws_efs_file_system.main.id]
}

# aws_efs_file_system
output "ecs_cluster_id" {
  description = "The Name, ID of the EFS"
  value       = data.terraform_remote_state.ecs.outputs.cluster_id
}

output "private_subnets" {
  description = "The private subnets"
  value       = slice(data.terraform_remote_state.vpc.outputs.private_subnets, 0, length(data.terraform_remote_state.vpc.outputs.private_subnets))
}

output "aws_alb_dns_name" {
  description = "The private subnets"
  value       = aws_alb.application_load_balancer.dns_name
}

output "testing" {
  value = "Test this demo code by going to https://${aws_route53_record.main.fqdn} and checking your have a valid SSL cert"
}

output "aws_acm_certificate_id" {
  description = "The ID of the ACM"
  value       = aws_acm_certificate.main.id
}

output "aws_acm_certificate_domain_validation_options" {
  description = "The ID of the ACM"
  value       = aws_acm_certificate.main.domain_validation_options
}

output "aws_acm_certificate_validation_arn" {
  description = "The ARN of the ACM"
  value       = aws_acm_certificate_validation.main.certificate_arn
}