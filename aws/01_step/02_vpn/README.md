# Terraform - Infrastructure as code

# VPC | Amazon Virtual Private Cloud

## Init
```
cat > terraform.tfvars <<ENDLINE
aws_region                 = "us-east-1"
project_name               = "vpc-xxxxxxxxxx"
environment                = "production"
vpc_cidr_block             = "172.31.0.0/16"
public_subnet_cidr_blocks  = ["172.31.1.0/24", "172.31.2.0/24", "172.31.3.0/24"]
private_subnet_cidr_blocks = ["172.31.31.0/24", "172.31.32.0/24", "172.31.33.0/24"]
intra_subnet_cidr_blocks   = ["172.31.61.0/24", "172.31.62.0/24", "172.31.63.0/24"]
enable_nat_gateway         = true
enable_vpn_gateway         = false
enable_dns_hostnames       = true
enable_dns_support         = true
ENDLINE
```

```
cat > terraform.backend.tfvars <<ENDLINE
bucket         = "terraform-remote-state-xxxxxxxxxx"
key            = "terraform/us-east-1/vpc/vpc.tfstate"
region         = "us-east-1"
encrypt        = true
dynamodb_table = "terraform-remote-state-lock-xxxxxxxxxx"
ENDLINE
```

```
terraform init -backend-config=terraform.backend.tfvars
```