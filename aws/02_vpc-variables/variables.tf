/*
  Doc: https://learn.hashicorp.com/tutorials/terraform/variables?in=terraform/configuration-language
*/

variable "project_name" {
  description = "Project name"
  type        = string
  default     = "VPC-TESTING-01"
}

variable "environment" {
  description = "Environment"
  type        = string
  default     = "testing"
}

variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "vpc_cidr_block" {
  description = "CIDR block for VPC"
  type        = string
  default     = "172.17.0.0/16"
}

variable "private_subnet_cidr_blocks" {
  description = "Available cidr blocks for private subnets."
  type        = list(string)
  default = [
    "172.17.1.0/24",
    "172.17.2.0/24",
    "172.17.3.0/24",
  ]
}

variable "public_subnet_cidr_blocks" {
  description = "Available cidr blocks for public subnets."
  type        = list(string)
  default = [
    "172.17.51.0/24",
    "172.17.52.0/24",
    "172.17.53.0/24",
  ]
}

variable "intra_subnet_cidr_blocks" {
  description = "Available cidr blocks for intra subnets."
  type        = list(string)
  default = [
    "172.17.101.0/24",
    "172.17.102.0/24",
    "172.17.103.0/24",
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
