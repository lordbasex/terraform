# variables.tf | Definition of variables

variable "project_name" {
  description = "Project name"
  type        = string
}

variable "terraform_remote_state_name" {
  description = "Terraform Remote State Name"
  type        = string
}

variable "domain_name" {
  description = "Domain name"
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

variable "ingress_rules" {
  description = "ingress_rules"
}

variable "egress_rules" {
  description = "egress_rules"
}