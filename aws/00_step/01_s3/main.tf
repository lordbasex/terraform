module "backend" {
  source       = "github.com/lordbasex/terraform-modules/aws/backend"
  aws_region   = var.aws_region
  project_name = var.project_name
}