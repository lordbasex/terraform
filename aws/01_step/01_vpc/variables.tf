variable "project_name" {
  description = "Project name"
  type        = string
}

variable "environment" {
  description = "Environment"
  type        = string
}

variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "vpc_cidr_block" {
  description = "CIDR block for VPC"
  type        = string
}

variable "public_subnet_cidr_blocks" {
  description = "Available cidr blocks for public subnets."
  type        = list(string)
}

variable "private_subnet_cidr_blocks" {
  description = "Available cidr blocks for private subnets."
  type        = list(string)
}

variable "intra_subnet_cidr_blocks" {
  description = "Available cidr blocks for intra subnets."
  type        = list(string)
}

variable "enable_nat_gateway" {
  description = "NAT Gateway"
  type        = bool
}

variable "enable_vpn_gateway" {
  description = "VPN Gateway"
  type        = bool
}

variable "enable_dns_hostnames" {
  description = "VPN Gateway"
  type        = bool
}

variable "enable_dns_support" {
  description = "DNS hostnames in the VPC"
  type        = bool
}