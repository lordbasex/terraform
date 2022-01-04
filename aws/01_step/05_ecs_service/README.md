# Terraform - Infrastructure as code

# ECS Amazon Elastic Container Service

## Init
```
cat > terraform.tfvars <<ENDLINE
aws_region                  = "us-east-1"
project_name                = "wiki"
terraform_remote_state_name = "terraform-remote-state-xxxxxxxxxx"
domain_name                 = "xxxxxxxxxx.net"
environment                 = "production"
ingress_rules = [
  {
    description      = "HTTP"
    from_port        = "80"
    to_port          = "80"
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  },
  {
    description      = "HTTPS"
    from_port        = "443"
    to_port          = "443"
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
]

egress_rules = [
  {
    description      = "NAT"
    from_port        = "0"
    to_port          = "0"
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
]
ENDLINE
```

```
cat > terraform.backend.tfvars <<ENDLINE
bucket         = "terraform-remote-state-xxxxxxxxxx"
key            = "terraform/us-east-1/ecs/aws_ecs_service_wiki.tfstate"
region         = "us-east-1"
encrypt        = true
dynamodb_table = "terraform-remote-state-lock-xxxxxxxxxx"
ENDLINE
```

```
terraform init -backend-config=terraform.backend.tfvars
terraform plan
terraform apply
```