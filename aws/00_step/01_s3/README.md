# Terraform - Infrastructure as code

# Backend | Amazon S3

## Init
```
cat > terraform.tfvars <<ENDLINE
project_name = "xxxxxxxxxx"
aws_region   = "us-east-1"
ENDLINE
```

```
terraform init
terraform plan
terraform apply
```