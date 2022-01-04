# Terraform - Infrastructure as code

# ECR | Amazon Elastic Container Registry

## Init
```
cat > terraform.tfvars <<ENDLINE
aws_region                 = "us-east-1"
project_name               = "wiki"
environment                = "production"
ENDLINE
```

```
cat > terraform.backend.tfvars <<ENDLINE
bucket         = "terraform-remote-state-xxxxxxxxxx"
key            = "terraform/us-east-1/ecr/aws_ecr_wiki.tfstate"
region         = "us-east-1"
encrypt        = true
dynamodb_table = "terraform-remote-state-lock-xxxxxxxxxx"
ENDLINE
```

```
terraform init -backend-config=terraform.backend.tfvars
```