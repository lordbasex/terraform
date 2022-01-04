resource "aws_ecr_repository" "main" {
  name                 = "${var.project_name}-ecr"
  image_tag_mutability = "MUTABLE"
  tags = {
    Name         = "${var.project_name}-${var.environment}-ecr"
    Terraform    = "true"
    Environment  = var.environment
    project_name = var.project_name
  }
}

resource "aws_ecr_lifecycle_policy" "main" {
  repository = aws_ecr_repository.main.name

  policy = jsonencode({
    rules = [{
      rulePriority = 1
      description  = "keep last 10 images"
      action = {
        type = "expire"
      }
      selection = {
        tagStatus   = "any"
        countType   = "imageCountMoreThan"
        countNumber = 10
      }
    }]
  })
}