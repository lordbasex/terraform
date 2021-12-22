/*
  Doc: https://learn.hashicorp.com/tutorials/terraform/variables?in=terraform/configuration-language
*/

variable "project_name" {
  description = "Project name"
  type        = string
  default     = "VPC-MyProjectName"
}

variable "environment" {
  description = "Environment"
  type        = string
  default     = "Production"
}

variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "vpc_cidr_block" {
  description = "CIDR block for VPC"
  type        = string
  default     = "172.31.0.0/16"
}

variable "public_subnet_cidr_blocks" {
  description = "Available cidr blocks for public subnets."
  type        = list(string)
  default = [
    "172.31.1.0/24",
    "172.31.2.0/24",
    "172.31.3.0/24",
  ]
}

variable "private_subnet_cidr_blocks" {
  description = "Available cidr blocks for private subnets."
  type        = list(string)
  default = [
    "172.31.31.0/24",
    "172.31.32.0/24",
    "172.31.33.0/24",
  ]
}

variable "intra_subnet_cidr_blocks" {
  description = "Available cidr blocks for intra subnets."
  type        = list(string)
  default = [
    "172.31.61.0/24",
    "172.31.62.0/24",
    "172.31.63.0/24",
  ]
}

variable "enable_nat_gateway" {
  description = "NAT Gateway"
  default     = true
}

variable "enable_vpn_gateway" {
  description = "VPN Gateway"
  default     = false
}

variable "enable_dns_hostnames" {
  description = "VPN Gateway"
  default     = true
}

variable "enable_dns_support" {
  description = "DNS hostnames in the VPC"
  default     = true
}
