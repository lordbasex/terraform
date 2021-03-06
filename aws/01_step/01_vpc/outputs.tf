output "enabled_regions" {
  description = "A list of regions that are enabled in the account"
  value       = data.aws_availability_zones.available.names
}

# VPC
output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
}

# Subnets
output "private_subnets" {
  description = "List of IDs of private subnets"
  value       = module.vpc.private_subnets
}

output "private_subnet_cidr_blocks" {
  description = "List of IDs of private subnets cidr_blocks"
  value       = var.private_subnet_cidr_blocks
}

output "public_subnets" {
  description = "List of IDs of public subnets"
  value       = module.vpc.public_subnets
}

output "public_subnet_cidr_blocks" {
  description = "List of IDs of public subnets"
  value       = var.public_subnet_cidr_blocks
}

output "intra_subnets" {
  description = "List of IDs of intra subnets"
  value       = module.vpc.intra_subnets
}

output "intra_subnet_cidr_blocks" {
  description = "List of IDs of intra subnets"
  value       = var.intra_subnet_cidr_blocks
}

# NAT gateways
output "nat_public_ips" {
  description = "List of public Elastic IPs created for AWS NAT Gateway"
  value       = module.vpc.nat_public_ips
}
