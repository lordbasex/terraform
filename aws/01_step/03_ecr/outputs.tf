output "ecr_repository_url" {
  description = "The URL of the REPOSITORY"
  value       = aws_ecr_repository.main.repository_url
}

