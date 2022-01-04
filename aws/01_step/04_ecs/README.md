# Terraform - Infrastructure as code

# ECS | Amazon Elastic Container Service

## Init
```
cat > terraform.tfvars <<ENDLINE
aws_region                 = "us-east-1"
project_name               = "cluster-example"
environment                = "production"
ENDLINE
```

```
cat > terraform.backend.tfvars <<ENDLINE
bucket         = "terraform-remote-state-xxxxxxxxxx"
key            = "terraform/us-east-1/ecs/aws_ecs_cluster.tfstate"
region         = "us-east-1"
encrypt        = true
dynamodb_table = "terraform-remote-state-lock-xxxxxxxxxx"
ENDLINE
```

```
terraform init -backend-config=terraform.backend.tfvars
```