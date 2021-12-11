module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  name   = "${var.project_name}-${var.environment}"
  cidr   = "172.17.0.0/16"

  azs             = ["${var.region}a", "${var.region}b", "${var.region}c"]
  private_subnets = ["172.17.1.0/24", "172.17.2.0/24", "172.17.3.0/24"]
  public_subnets  = ["172.17.51.0/24", "172.17.52.0/24", "172.17.53.0/24"]
  intra_subnets   = ["172.17.101.0/24", "172.17.102.0/24", "172.17.103.0/24"]

  enable_nat_gateway = true
  # enable_vpn_gateway = true

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
