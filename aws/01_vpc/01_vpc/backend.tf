terraform {
  backend "s3" {
    bucket         = "terraform-remote-state-MyProjectName"
    key            = "terraform/vpc/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "terraform-remote-state-lock-MyProjectName"
  }
}
