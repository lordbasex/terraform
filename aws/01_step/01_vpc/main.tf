data "aws_availability_zones" "available" {}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  name   = "${var.project_name}-${var.environment}"
  cidr   = var.vpc_cidr_block

  azs             = data.aws_availability_zones.available.names
  private_subnets = slice(var.private_subnet_cidr_blocks, 0, length(var.private_subnet_cidr_blocks))
  public_subnets  = slice(var.public_subnet_cidr_blocks, 0, length(var.public_subnet_cidr_blocks))
  intra_subnets   = slice(var.intra_subnet_cidr_blocks, 0, length(var.intra_subnet_cidr_blocks))

  enable_nat_gateway   = var.enable_nat_gateway
  enable_vpn_gateway   = var.enable_vpn_gateway
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support   = var.enable_dns_support

  private_subnet_tags = {
    Name = "${var.project_name}-private"
  }

  public_subnet_tags = {
    Name = "${var.project_name}-public"
  }

  intra_subnet_tags = {
    Name = "${var.project_name}-intra"
  }

  tags = {
    Terraform    = "true"
    Environment  = var.environment
    project_name = var.project_name
  }
}
