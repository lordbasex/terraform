# acm.tf | AWS Certificate Manager

resource "aws_acm_certificate" "main" {
  domain_name       = "${var.project_name}.${var.domain_name}"
  validation_method = "DNS"

  tags = {
    Name         = "${var.project_name}-${var.environment}-acm"
    Terraform    = "true"
    Environment  = var.environment
    project_name = var.project_name
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_acm_certificate_validation" "main" {
  certificate_arn         = aws_acm_certificate.main.arn
  validation_record_fqdns = [for record in aws_route53_record.validation : record.fqdn]
}